# Changelog

## 1.7.2

### 🐛 Bug Fixes

* Scope RCLONE_LOG_LEVEL to backrest service to fix conflict with --verbose in scheduler ([c6b3e86](https://github.com/dig12345/hassio-rclone-scripts/commit/c6b3e86b32fac98ec8ce38a6cc529ac77a6a74fb))

**Full Changelog**: [`v1.7.1...v1.7.2`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.7.1...v1.7.2)

## 1.7.1

### ♻️ Refactoring

* Expose backrest and rclone ports directly, remove socat proxy ([3f9c01c](https://github.com/dig12345/hassio-rclone-scripts/commit/3f9c01c6c61007a4f536b27a3be892ec0666a006))


### 🚦 Test

* Remove ingress to expose direct port access in Network tab ([3b1fcc9](https://github.com/dig12345/hassio-rclone-scripts/commit/3b1fcc9ff5659716d427a0e5277bb855f7ba2986))

**Full Changelog**: [`v1.7.0...v1.7.1`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.7.0...v1.7.1)

## 1.7.0

### ✨ Features

* Add ports_description for backrest and rclone web UIs ([74427eb](https://github.com/dig12345/hassio-rclone-scripts/commit/74427ebe27a79b5f3ab102c6f27773372f7ba33d))

**Full Changelog**: [`v1.6.1...v1.7.0`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.6.1...v1.7.0)

## 1.6.1

### 🐛 Bug Fixes

* Suppress rclone log level to prevent Supervisor event loop flooding ([35e58a6](https://github.com/dig12345/hassio-rclone-scripts/commit/35e58a6fcc3c23ddc6b2aa6d101f77452edf598e))

**Full Changelog**: [`v1.6.0...v1.6.1`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.6.0...v1.6.1)

## 1.6.0

### ✨ Features

* Expose backrest on port 8098 via socat forwarder ([2cf810e](https://github.com/dig12345/hassio-rclone-scripts/commit/2cf810efc670ebae017791bb0dd2b84955b7b72e))

**Full Changelog**: [`v1.5.0...v1.6.0`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.5.0...v1.6.0)

## 1.5.0

### ✨ Features

* Expose backrest on port 9898 ([cd1246b](https://github.com/dig12345/hassio-rclone-scripts/commit/cd1246b5b979df96d342421a5ab908f77e941334))

**Full Changelog**: [`v1.4.0...v1.5.0`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.4.0...v1.5.0)

## 1.4.0

### ✨ Features

* Remove Jobs API and UI ([1a05567](https://github.com/dig12345/hassio-rclone-scripts/commit/1a05567ed4759543a45f82a5b449153014334099))

**Full Changelog**: [`v1.3.5...v1.4.0`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.3.5...v1.4.0)

## 1.3.5

### 🐛 Bug Fixes

* Remove ingress_stream to prevent nginx worker exhaustion during backups ([ca85491](https://github.com/dig12345/hassio-rclone-scripts/commit/ca8549102a0b948357a7ee5a7b927c99bf9f03e2))


### ⚙️ Continuous Integration

* Publish release only after image is built and pushed ([b2b362e](https://github.com/dig12345/hassio-rclone-scripts/commit/b2b362ec40b40de08a2237a67a3109cbf9b9ecdc))

**Full Changelog**: [`v1.3.4...v1.3.5`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.3.4...v1.3.5)

## 1.3.4

### 🐛 Bug Fixes

* Remove FUSE to prevent Supervisor network interference ([f79b2ac](https://github.com/dig12345/hassio-rclone-scripts/commit/f79b2ac2fef9c77b4ff28a02b14b64ab9fc13f50))

**Full Changelog**: [`v1.3.3...v1.3.4`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.3.3...v1.3.4)

## 1.3.3

### 🐛 Bug Fixes

* Expose rclone web UI on port 8097 (internal 8099) ([e11a5f3](https://github.com/dig12345/hassio-rclone-scripts/commit/e11a5f36f86211dc04f69d649680b2a1677de132))

**Full Changelog**: [`v1.3.2...v1.3.3`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.3.2...v1.3.3)

## 1.3.2

### 🐛 Bug Fixes

* Expose rclone web UI port 8099 ([0131354](https://github.com/dig12345/hassio-rclone-scripts/commit/0131354b23e73b6da0cb4e42f169a06ff89d8446))

**Full Changelog**: [`v1.3.1...v1.3.2`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.3.1...v1.3.2)

## 1.3.1

### 🐛 Bug Fixes

* Add ingress_stream to fix backrest UI connectivity errors ([9d71931](https://github.com/dig12345/hassio-rclone-scripts/commit/9d71931e540bd3347acbc304f5d971cffc0bec0b))


### 📚 Documentation

* Update rclone.conf path references to new location ([b6d3ec2](https://github.com/dig12345/hassio-rclone-scripts/commit/b6d3ec2bf8465f40c5fdb425dc424117c7f63050))

**Full Changelog**: [`v1.3.0...v1.3.1`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.3.0...v1.3.1)

## 1.3.0

### ✨ Features

* Reorganise all config and data under /homeassistant/rclone_backup ([484f994](https://github.com/dig12345/hassio-rclone-scripts/commit/484f994f3b1e59a1dd0295443b6797b3c9c5d566))


### 🏗️ Chore

* Drop all architectures except amd64 ([72a06b5](https://github.com/dig12345/hassio-rclone-scripts/commit/72a06b5ccf369c181d66b57f92b984c70a551a65))

**Full Changelog**: [`v1.2.3...v1.3.0`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.2.3...v1.3.0)

## 1.2.3

### 🐛 Bug Fixes

* Set BACKREST_CONFIG env var to persist backrest settings ([47281dc](https://github.com/dig12345/hassio-rclone-scripts/commit/47281dc7a743e6fdc972e8783c4d382ec7205bc3))

**Full Changelog**: [`v1.2.2...v1.2.3`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.2.2...v1.2.3)

## 1.2.2

### 🐛 Bug Fixes

* Log BACKREST_DATA path on startup for debugging ([314c269](https://github.com/dig12345/hassio-rclone-scripts/commit/314c26930445bfc6ca98e042fd958cc8785adfcb))

**Full Changelog**: [`v1.2.1...v1.2.2`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.2.1...v1.2.2)

## 1.2.1

### 🐛 Bug Fixes

* Write BACKREST_DATA to s6 container environment ([e94fdde](https://github.com/dig12345/hassio-rclone-scripts/commit/e94fdde832224514911312fb7118a46123d86257))


### ⚙️ Continuous Integration

* Add actions:write permission and fix deploy ref ([637c2e5](https://github.com/dig12345/hassio-rclone-scripts/commit/637c2e5ab08a945d016ff1f1e3cd5ab29c8e376c))

**Full Changelog**: [`v1.2.0...v1.2.1`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.2.0...v1.2.1)

## 1.2.0

### ✨ Features

* Switch ingress to Backrest UI ([fcb3769](https://github.com/dig12345/hassio-rclone-scripts/commit/fcb37694d0a086c6adac235439f45f28338d4202))


### ⚙️ Continuous Integration

* Auto-trigger deploy after release, add workflow_dispatch to deploy ([aca9711](https://github.com/dig12345/hassio-rclone-scripts/commit/aca9711fd17e3bd8db9604ee08cd8b2831053242))

**Full Changelog**: [`v1.1.0...v1.2.0`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.1.0...v1.2.0)

## 1.1.0

### ✨ Features

* Add backrest web UI for restic ([879672b](https://github.com/dig12345/hassio-rclone-scripts/commit/879672b879b1d7ae5a6ad7f3891fca3054b5c427))


### ⚙️ Continuous Integration

* Trigger release workflow on push to main ([ebc5e9e](https://github.com/dig12345/hassio-rclone-scripts/commit/ebc5e9eb8f458ef80a60ecb8113239b51cb42bff))

**Full Changelog**: [`v1.0.9...v1.1.0`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.0.9...v1.1.0)

## 1.0.9

**Full Changelog**: [`v1.0.8...v1.0.9`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.0.8...v1.0.9)

## 1.0.8

**Full Changelog**: [`v1.0.7...v1.0.8`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.0.7...v1.0.8)

## 1.0.7

**Full Changelog**: [`v1.0.6...v1.0.7`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.0.6...v1.0.7)

## 1.0.6

**Full Changelog**: [`v1.0.5...v1.0.6`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.0.5...v1.0.6)

## 1.0.5

**Full Changelog**: [`v1.0.4...v1.0.5`](https://github.com/dig12345/hassio-rclone-scripts/compare/v1.0.4...v1.0.5)

## 1.0.4

**Full Changelog**: [`v3.3.5...v1.0.4`](https://github.com/dig12345/hassio-rclone-scripts/compare/v3.3.5...v1.0.4)

## 3.3.5

### 📦 Build

* **deps:** Update actions/checkout action to v5 ([#114](https://github.com/dig12345/hassio-rclone-scripts/issues/114)) ([586af1e](https://github.com/dig12345/hassio-rclone-scripts/commit/586af1e6eae4ce36fb5781bd3adc08639f78709a))
* **deps:** Update actions/checkout action to v6 ([#122](https://github.com/dig12345/hassio-rclone-scripts/issues/122)) ([53f6b64](https://github.com/dig12345/hassio-rclone-scripts/commit/53f6b64e1cab4d4355b483f36a6e027cb9a09bac))
* **deps:** Update actions/setup-node action to v5 ([#118](https://github.com/dig12345/hassio-rclone-scripts/issues/118)) ([55f5400](https://github.com/dig12345/hassio-rclone-scripts/commit/55f54007738acb27c5730dd69ace4da8f1f8c798))
* **deps:** Update actions/setup-node action to v6 ([#120](https://github.com/dig12345/hassio-rclone-scripts/issues/120)) ([dd6a40a](https://github.com/dig12345/hassio-rclone-scripts/commit/dd6a40aa9b0d353b55bcb895bd840a7d79421bb6))
* **deps:** Update all non-major dependencies ([#108](https://github.com/dig12345/hassio-rclone-scripts/issues/108)) ([8456008](https://github.com/dig12345/hassio-rclone-scripts/commit/84560089561dba2e0caac402cb855b90c997fa95))
* **deps:** Update all non-major dependencies ([#109](https://github.com/dig12345/hassio-rclone-scripts/issues/109)) ([653588f](https://github.com/dig12345/hassio-rclone-scripts/commit/653588fd209463718916d7214624a1929d0086f6))
* **deps:** Update all non-major dependencies ([#113](https://github.com/dig12345/hassio-rclone-scripts/issues/113)) ([c686e65](https://github.com/dig12345/hassio-rclone-scripts/commit/c686e65c8cddd0126e0bbafa2f2d2af8d73e4c2f))
* **deps:** Update all non-major dependencies ([#117](https://github.com/dig12345/hassio-rclone-scripts/issues/117)) ([00358b8](https://github.com/dig12345/hassio-rclone-scripts/commit/00358b8d3e41ef95d9c20fd9860d8636cd01000f))
* **deps:** Update all non-major dependencies ([#119](https://github.com/dig12345/hassio-rclone-scripts/issues/119)) ([20ebe23](https://github.com/dig12345/hassio-rclone-scripts/commit/20ebe2396d4d1ebbe7a920e52b71b738974b4a65))
* **deps:** Update all non-major dependencies ([#121](https://github.com/dig12345/hassio-rclone-scripts/issues/121)) ([327db82](https://github.com/dig12345/hassio-rclone-scripts/commit/327db821bce4f8f165f9ec404c5554e628a8d0c9))
* **deps:** Update all non-major dependencies ([#123](https://github.com/dig12345/hassio-rclone-scripts/issues/123)) ([598f6e9](https://github.com/dig12345/hassio-rclone-scripts/commit/598f6e9c912c2fe72001171c8e6d47926683c609))

**Full Changelog**: [`v3.3.4...v3.3.5`](https://github.com/dig12345/hassio-rclone-scripts/compare/v3.3.4...v3.3.5)

## 3.3.4

### 🏗️ Chore

* Fix some dockerfile warnings ([ab65571](https://github.com/dig12345/hassio-rclone-scripts/commit/ab655714260a73830df7be4c3753e54bc97fd6f2))


### 📦 Build

* **deps:** Update add-on base python image to v16 (major) ([#100](https://github.com/dig12345/hassio-rclone-scripts/issues/100)) ([71146dd](https://github.com/dig12345/hassio-rclone-scripts/commit/71146ddb0c4dc6940fe2f4753de34ab6aec3382d))
* **deps:** Update all non-major dependencies ([#99](https://github.com/dig12345/hassio-rclone-scripts/issues/99)) ([2cd82b9](https://github.com/dig12345/hassio-rclone-scripts/commit/2cd82b9cd9f02b0629b59a57e2c46db538c055b7))

**Full Changelog**: [`v3.3.3...v3.3.4`](https://github.com/dig12345/hassio-rclone-scripts/compare/v3.3.3...v3.3.4)

## 3.3.3

### 🐛 Bug Fixes

* Error when mounting fuse fs ([#88](https://github.com/dig12345/hassio-rclone-scripts/issues/88)) ([66d8601](https://github.com/dig12345/hassio-rclone-scripts/commit/66d8601ce0d0f35d81ab6a7651f46c8a56008ddb))


### 📦 Build

* **deps:** Update add-on base python image to v15 ([1ab5981](https://github.com/dig12345/hassio-rclone-scripts/commit/1ab5981546e7e28454ff0993808bcb08fd558454))
* **deps:** Update all non-major dependencies ([62352d0](https://github.com/dig12345/hassio-rclone-scripts/commit/62352d0d6d811c9b525316cb700a9e6970f8e4de))
* **deps:** Update all non-major dependencies ([#98](https://github.com/dig12345/hassio-rclone-scripts/issues/98)) ([f7cdd0b](https://github.com/dig12345/hassio-rclone-scripts/commit/f7cdd0b3d1467d3a54f9f8cd5cb827e609b4e4bb))


### ⚙️ Continuous Integration

* Update renovate config ([7c05749](https://github.com/dig12345/hassio-rclone-scripts/commit/7c05749f2b4c58307a4f27fcf921407783232abf))
* Update renovate config ([d411024](https://github.com/dig12345/hassio-rclone-scripts/commit/d4110246915c4b91e1a4a86b8f2602490b71e83c))

**Full Changelog**: [`v3.3.2...v3.3.3`](https://github.com/dig12345/hassio-rclone-scripts/compare/v3.3.2...v3.3.3)

## 3.3.2

### 📚 Documentation

* Add example for pruning old backups ([#78](https://github.com/dig12345/hassio-rclone-scripts/issues/78)) ([01ef01a](https://github.com/dig12345/hassio-rclone-scripts/commit/01ef01af7c2c62ffc9ce8e26a960cfc2940ce0c3)), closes [#75](https://github.com/dig12345/hassio-rclone-scripts/issues/75)


### 📦 Build

* **deps:** Update add-on base image to v14 ([0b743fa](https://github.com/dig12345/hassio-rclone-scripts/commit/0b743fa37bd5dca05b9d9aa3bf6b23a2f5eac67e))
* **deps:** Update all non-major dependencies ([75532c9](https://github.com/dig12345/hassio-rclone-scripts/commit/75532c9ab5b07db7088ead73a0721bc3ef843770))
* **deps:** Update all non-major dependencies ([f600337](https://github.com/dig12345/hassio-rclone-scripts/commit/f600337dda25fbe9b5b34ed649516254146e0a33))
* **deps:** Update all non-major dependencies ([b4ea62b](https://github.com/dig12345/hassio-rclone-scripts/commit/b4ea62b549f112f54da8d341afc69ab323117298))
* **deps:** Update all non-major dependencies ([a7b6a30](https://github.com/dig12345/hassio-rclone-scripts/commit/a7b6a3011beb6cb04cef73118e0c9c6ccd102cc7))

**Full Changelog**: [`v3.3.1...v3.3.2`](https://github.com/dig12345/hassio-rclone-scripts/compare/v3.3.1...v3.3.2)

## 3.3.1

### 📦 Build

* **deps:** Update all non-major dependencies ([6779f0b](https://github.com/dig12345/hassio-rclone-scripts/commit/6779f0b48ea4f0ecd61c79c0d631d94662016781))
* **deps:** Update docker/build-push-action action to v6 ([5b4af5f](https://github.com/dig12345/hassio-rclone-scripts/commit/5b4af5f46333bbb2f3b2ec2665b3c2e06fd9de97))

**Full Changelog**: [`v3.3.0...v3.3.1`](https://github.com/dig12345/hassio-rclone-scripts/compare/v3.3.0...v3.3.1)

## 3.3.0

### ✨ Features

* Add write access to `addons` and `all_addon_configs` ([d25db6b](https://github.com/dig12345/hassio-rclone-scripts/commit/d25db6b7abb172e067d8a45d44a9de28e1761d1d))
* Add write permissions to media and shared paths ([#57](https://github.com/dig12345/hassio-rclone-scripts/issues/57)) ([cde6bab](https://github.com/dig12345/hassio-rclone-scripts/commit/cde6bab17ea314bd1b73ac9a7b243f5329ae4a57))
* Support new `homeassistant` directory ([3e87c84](https://github.com/dig12345/hassio-rclone-scripts/commit/3e87c843820978f346bdcb1ca211634667a29d9d))


### 📦 Build

* **deps:** Update add-on base image to v13 (major) ([#66](https://github.com/dig12345/hassio-rclone-scripts/issues/66)) ([b49c914](https://github.com/dig12345/hassio-rclone-scripts/commit/b49c914f5fbea7be446d495856c0844c1b8913a6))


### ⚙️ Continuous Integration

* Add `build.yaml` to renovate config ([05b9d8d](https://github.com/dig12345/hassio-rclone-scripts/commit/05b9d8d392eebac9e29a753de58863950aa8a6c1))
* Improve build workflow ([2d50292](https://github.com/dig12345/hassio-rclone-scripts/commit/2d502928eca8f7ce20c489aa0e076d7d0aa53210))
* Update release workflow ([615b101](https://github.com/dig12345/hassio-rclone-scripts/commit/615b1018b295a4d302f5811e17ad603544d7ad8e))

**Full Changelog**: [`v3.2.0...v3.3.0`](https://github.com/dig12345/hassio-rclone-scripts/compare/v3.2.0...v3.3.0)

## 3.2.0

### 📦 Build

* **deps:** Update actions/checkout action to v4 ([#62](https://github.com/dig12345/hassio-rclone-scripts/pull/62))
* **deps:** Update docker/login-action action to v3 ([#63](https://github.com/dig12345/hassio-rclone-scripts/pull/63))
* **deps:** Update all non-major dependencies ([#61](https://github.com/dig12345/hassio-rclone-scripts/pull/61))
  * updated to `rclone` to `v1.66.0`
* **deps:** Update module github.com/go-co-op/gocron to v2 ([#64](https://github.com/dig12345/hassio-rclone-scripts/pull/64))
* **deps:** Update go.mod version to 1.22 ([dd73c29](https://github.com/dig12345/hassio-rclone-scripts/commit/dd73c2914c96c95aaa0d1262492d5caa1bf3fc39))

### ⚙️ Continuous Integration

* Add renovate config ([2bb7d50](https://github.com/dig12345/hassio-rclone-scripts/commit/2bb7d50ec5202c565afe462fa87f7c478928d9ad))

**Full Changelog**: [`3.1.0...3.2.0`](https://github.com/dig12345/hassio-rclone-scripts/compare/3.1.0...3.2.0)
