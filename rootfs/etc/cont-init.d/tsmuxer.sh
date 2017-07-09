#!/usr/bin/with-contenv sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

# Copy default config if needed.
for FILE in tsMuxeR.conf Trolltech.conf
do
    if [ ! -f /config/"$FILE" ]; then
        cp /defaults/"$FILE" /config/
    fi
done

# Take ownership of the config directory.
chown -R $USER_ID:$GROUP_ID /config

# Take ownership of the output directory.
chown $USER_ID:$GROUP_ID /output

# vim: set ft=sh :
