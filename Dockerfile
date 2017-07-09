#
# tsmuxer Dockerfile
#
# https://github.com/jlesage/docker-tsmuxer
#

# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.6-v1.5.0

# Define working directory.
WORKDIR /tmp

# Install tsMuxeR.
ADD tsmuxer-builder/tsmuxer.tar.gz /

# Configuration files should be stored outside the container.
RUN \
    mkdir -p $HOME/.config/"Network Optix" && \
    ln -s /config/tsMuxeR.conf $HOME/.config/"Network Optix"/tsMuxeR.conf && \
    ln -s /config/Trolltech.conf $HOME/.config/Trolltech.conf

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/tsmuxer-icon.png && \
    /opt/install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /

# Set environment variables.
ENV APP_NAME="tsMuxeR"

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/storage"]
VOLUME ["/output"]

# Metadata.
LABEL \
      org.label-schema.name="tsmuxer" \
      org.label-schema.description="Docker container for tsMuxeR" \
      org.label-schema.version="unknown" \
      org.label-schema.vcs-url="https://github.com/jlesage/docker-tsmuxer" \
      org.label-schema.schema-version="1.0"
