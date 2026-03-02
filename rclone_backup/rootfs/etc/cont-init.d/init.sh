#!/usr/bin/with-contenv bashio

CONFIG_PATH="/homeassistant/rclone.conf"

# backwards compatible with config directory
ln -s "/homeassistant" "/config" \
    || bashio::log.warning "Failed linking common directory: /config"

if bashio::config.has_value "rclone_config"; then
  # write rclone config from addon config
  CONFIG_PATH="/root/.config/rclone/rclone.conf"
  echo -n "$(bashio::config "rclone_config")" > "$CONFIG_PATH"
elif bashio::config.has_value "config_path"; then
  CONFIG_PATH=$(bashio::config "config_path")
fi

echo -n "$CONFIG_PATH" > /var/run/s6/container_environment/RCLONE_CONFIG

# Load fuse kernel module so Web UI mount works (privileged addon shares host kernel)
if modprobe fuse 2>/dev/null; then
  bashio::log.info "Loaded fuse kernel module"
else
  bashio::log.warning "Could not load fuse module (Web UI mount may fail); on the host run: modprobe fuse"
fi
