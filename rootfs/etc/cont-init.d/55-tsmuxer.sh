#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

mkdir -p "$XDG_CONFIG_HOME/Network Optix"

# Upgrade existing installations.
[ ! -f /config/tsMuxeR.conf ] || mv -v /config/tsMuxeR.conf "$XDG_CONFIG_HOME/Network Optix/"
[ ! -f /config/Trolltech.conf ] || mv -v /config/Trolltech.conf "$XDG_CONFIG_HOME/"

# Copy default config if needed.
[ -f /$XDG_CONFIG_HOME/"Network Optix"/tsMuxeR.conf ] || cp -v /defaults/tsMuxeR.conf "$XDG_CONFIG_HOME/Network Optix/"
[ -f /$XDG_CONFIG_HOME/Trolltech.conf ] || cp -v /defaults/Trolltech.conf "$XDG_CONFIG_HOME/"

# vim:ft=sh:ts=4:sw=4:et:sts=4
