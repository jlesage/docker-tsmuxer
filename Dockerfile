#
# tsmuxer Dockerfile
#
# https://github.com/jlesage/docker-tsmuxer
#

# Build tsMuxer.
FROM ubuntu:xenial
COPY tsmuxer-builder /tmp/tsmuxer-builder
RUN /tmp/tsmuxer-builder/builder/build.sh /tmp/

# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.8-v3.5.2

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=unknown

# Define working directory.
WORKDIR /tmp

# Install tsMuxeR.
COPY --from=0 /tmp/tsmuxer-install /

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
      org.label-schema.version="$DOCKER_IMAGE_VERSION" \
      org.label-schema.vcs-url="https://github.com/jlesage/docker-tsmuxer" \
      org.label-schema.schema-version="1.0"
