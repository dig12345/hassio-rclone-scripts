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

# Set Backrest environment in container environment so it persists across service restarts
BACKREST_DATA="/share/backrest"
if bashio::config.has_value "backrest_data_path"; then
    BACKREST_DATA=$(bashio::config "backrest_data_path")
fi
mkdir -p "${BACKREST_DATA}"
echo -n "${BACKREST_DATA}" > /var/run/s6/container_environment/BACKREST_DATA
echo -n "/usr/bin/restic" > /var/run/s6/container_environment/BACKREST_RESTIC_COMMAND

# Load fuse kernel module so Web UI mount works (privileged addon shares host kernel)
if modprobe fuse 2>/dev/null; then
  bashio::log.info "Loaded fuse kernel module (BACKREST_DATA=${BACKREST_DATA})"
else
  bashio::log.warning "Could not load fuse module (Web UI mount may fail); on the host run: modprobe fuse"
fi
