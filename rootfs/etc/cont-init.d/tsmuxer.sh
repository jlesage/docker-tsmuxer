#!/usr/bin/with-contenv sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

mkdir -p "$XDG_CONFIG_HOME/Network Optix"

# Upgrade existing installations.
[ ! -f /config/tsMuxeR.conf ] || mv -v /config/tsMuxeR.conf "$XDG_CONFIG_HOME/Network Optix/"
[ ! -f /config/Trolltech.conf ] || mv -v /config/Trolltech.conf "$XDG_CONFIG_HOME/"

# Copy default config if needed.
[ -f /config/"Network Optix"/tsMuxeR.conf ] || cp -v /defaults/tsMuxeR.conf "$XDG_CONFIG_HOME/Network Optix/"
[ -f /config/Trolltech.conf ] || cp -v /defaults/Trolltech.conf "$XDG_CONFIG_HOME/"

# Take ownership of the config directory content.
find /config -mindepth 1 -exec chown $USER_ID:$GROUP_ID {} \;

# vim: set ft=sh :
