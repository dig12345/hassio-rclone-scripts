#!/usr/bin/env bash
# Bump add-on version, commit, tag, push, and create a GitHub Release (triggers Docker build).
set -e

CONFIG="rclone_backup/config.yaml"
CHANGELOG="rclone_backup/CHANGELOG.md"
REMOTE="${REMOTE:-origin}"

usage() {
  echo "Usage: $0 [patch|minor|major|VERSION] [--no-push] [--no-changelog] [--no-release]"
  echo "  patch  - bump patch (1.0.0 -> 1.0.1)"
  echo "  minor  - bump minor (1.0.0 -> 1.1.0)"
  echo "  major  - bump major (1.0.0 -> 2.0.0)"
  echo "  VERSION - set exact version (e.g. 1.0.1)"
  echo "  --no-push     - commit and tag only, do not push"
  echo "  --no-changelog - do not add a new section to CHANGELOG.md"
  echo "  --no-release  - push but do not create GitHub Release (requires: gh auth login)"
  exit 1
}

NO_PUSH=
NO_CHANGELOG=
NO_RELEASE=
BUMP=

for arg in "$@"; do
  case "$arg" in
    --no-push)      NO_PUSH=1 ;;
    --no-changelog) NO_CHANGELOG=1 ;;
    --no-release)   NO_RELEASE=1 ;;
    patch|minor|major) BUMP="$arg" ;;
    [0-9]*.[0-9]*.[0-9]*) BUMP="$arg" ;;
    *) usage ;;
  esac
done

[[ -n "$BUMP" ]] || usage

# Resolve repo root (allow running from repo root or scripts/)
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")/.." && pwd)"
cd "$ROOT"

current="$(sed -n 's/^version: *//p' "$CONFIG")"
[[ -n "$current" ]] || { echo "Could not read version from $CONFIG"; exit 1; }

# Parse current version
IFS=. read -r major minor patch <<< "$current"

case "$BUMP" in
  patch)  patch=$((patch + 1)); new="${major}.${minor}.${patch}" ;;
  minor)  minor=$((minor + 1)); patch=0; new="${major}.${minor}.${patch}" ;;
  major)  major=$((major + 1)); minor=0; patch=0; new="${major}.${minor}.${patch}" ;;
  *)      new="$BUMP" ;;
esac

repo_url="$(git remote get-url "$REMOTE" 2>/dev/null | sed -E 's|^git@github.com:|https://github.com/|;s|\.git$||;s|^https://github.com/||')"
[[ -n "$repo_url" ]] || repo_url="dig12345/hassio-rclone-scripts"

echo "Bumping version: $current -> $new"

# Update config.yaml
if sed -i.bak "s/^version: .*/version: $new/" "$CONFIG"; then
  rm -f "$CONFIG.bak"
else
  echo "Failed to update $CONFIG"; exit 1
fi

# Add new changelog section (insert before first "## X.Y.Z" header; that version = previous for compare URL)
if [[ -z "$NO_CHANGELOG" ]]; then
  # First "## X.Y.Z" in CHANGELOG = previous version for compare URL (skip "## " = 4 chars)
  prev="$(awk '/^## [0-9]+\.[0-9]+\.[0-9]+$/ { print substr($0, 4); exit }' "$CHANGELOG")"
  [[ -n "$prev" ]] || prev="$current"
  compare_url="https://github.com/${repo_url}/compare/v${prev}...v${new}"

  bt=$'`'
  awk -v new="$new" -v prev="$prev" -v url="$compare_url" -v bt="$bt" '
    /^## [0-9]+\.[0-9]+\.[0-9]+$/ && !done {
      print "## " new
      print ""
      print "**Full Changelog**: [" bt "v" prev "...v" new bt "](" url ")"
      print ""
      done = 1
    }
    { print }
  ' "$CHANGELOG" > "$CHANGELOG.tmp" && mv "$CHANGELOG.tmp" "$CHANGELOG"
  echo "Updated $CHANGELOG"
fi

# Commit and tag
git add "$CONFIG"
[[ -z "$NO_CHANGELOG" ]] && git add "$CHANGELOG"
git commit -m "release: ${new} [skip ci]"
git tag "v${new}"

echo ""
echo "Committed and tagged v${new}."
branch="$(git rev-parse --abbrev-ref HEAD)"
if [[ -n "$NO_PUSH" ]]; then
  echo "Push when ready:"
  echo "  git push $REMOTE $branch"
  echo "  git push $REMOTE v${new}"
else
  git push "$REMOTE" "$branch"
  git push "$REMOTE" "v${new}"
  echo ""
  if [[ -z "$NO_RELEASE" ]] && command -v gh &>/dev/null; then
    echo "Creating GitHub Release v${new}..."
    if gh release create "v${new}" --title "Release ${new}" --generate-notes; then
      echo "Release created. Docker image will build from the release."
    else
      echo "Release failed (tag may already have a release). Docker build may still run if release existed."
    fi
    echo "  https://github.com/${repo_url}/releases"
  else
    if [[ -n "$NO_RELEASE" ]]; then
      echo "Skipped creating release (--no-release)."
    else
      echo "Install and log in to GitHub CLI to create a release: gh auth login"
      echo "Then: gh release create v${new} --title 'Release ${new}' --generate-notes"
    fi
    echo "  https://github.com/${repo_url}/actions"
  fi
fi
