#!/usr/bin/with-contenv bashio

# backwards compatible with config directory
ln -s "/homeassistant" "/config" \
    || bashio::log.warning "Failed linking common directory: /config"

# --- rclone config ---
CONFIG_PATH="/homeassistant/rclone_backup/rclone.conf"

if bashio::config.has_value "rclone_config"; then
  # write rclone config from addon config option
  CONFIG_PATH="/root/.config/rclone/rclone.conf"
  echo -n "$(bashio::config "rclone_config")" > "$CONFIG_PATH"
elif bashio::config.has_value "config_path"; then
  CONFIG_PATH=$(bashio::config "config_path")
fi

# Migrate rclone.conf from old default location
if [ "${CONFIG_PATH}" = "/homeassistant/rclone_backup/rclone.conf" ] \
    && [ ! -f "/homeassistant/rclone_backup/rclone.conf" ] \
    && [ -f "/homeassistant/rclone.conf" ]; then
    mkdir -p /homeassistant/rclone_backup
    mv /homeassistant/rclone.conf /homeassistant/rclone_backup/rclone.conf
    bashio::log.info "Migrated rclone.conf to /homeassistant/rclone_backup/rclone.conf"
fi

mkdir -p "$(dirname "${CONFIG_PATH}")"
echo -n "$CONFIG_PATH" > /var/run/s6/container_environment/RCLONE_CONFIG

if bashio::config.has_value "bwlimit"; then
    echo -n "$(bashio::config "bwlimit")" > /var/run/s6/container_environment/RCLONE_BWLIMIT
fi

# --- backrest config and data (all in HA config dir so HA backups cover it) ---
BACKREST_DATA="/homeassistant/rclone_backup/backrest"
if bashio::config.has_value "backrest_data_path"; then
    BACKREST_DATA=$(bashio::config "backrest_data_path")
fi

BACKREST_CONFIG="${BACKREST_DATA}/config.json"

# Migrate backrest data from old /share/backrest location
if [ ! -d "${BACKREST_DATA}" ] && [ -d "/share/backrest" ]; then
    mkdir -p "$(dirname "${BACKREST_DATA}")"
    mv /share/backrest "${BACKREST_DATA}"
    bashio::log.info "Migrated backrest data to ${BACKREST_DATA}"
fi

mkdir -p "${BACKREST_DATA}"

echo -n "${BACKREST_DATA}"   > /var/run/s6/container_environment/BACKREST_DATA
echo -n "${BACKREST_CONFIG}" > /var/run/s6/container_environment/BACKREST_CONFIG
echo -n "/usr/bin/restic"    > /var/run/s6/container_environment/BACKREST_RESTIC_COMMAND
