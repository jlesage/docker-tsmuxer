#
# tsmuxer Dockerfile
#
# https://github.com/jlesage/docker-tsmuxer
#

# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.6-v3.0.2

# Define working directory.
WORKDIR /tmp

# Install tsMuxeR.
ADD tsmuxer-builder/tsmuxer.tar.gz /

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/tsmuxer-icon.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /

# Set environment variables.
ENV APP_NAME="tsMuxeR"

# Define mountable directories.
VOLUME ["/config"]
VOLUME ["/storage"]

# Metadata.
LABEL \
      org.label-schema.name="tsmuxer" \
      org.label-schema.description="Docker container for tsMuxeR" \
      org.label-schema.version="unknown" \
      org.label-schema.vcs-url="https://github.com/jlesage/docker-tsmuxer" \
      org.label-schema.schema-version="1.0"
