#
# tsmuxer Dockerfile
#
# https://github.com/jlesage/docker-tsmuxer
#

# Docker image version is provided via build arg.
ARG DOCKER_IMAGE_VERSION=

# Define software versions.
ARG TSMUXER_VERSION=nightly-2024-06-06-02-00-53

# Define software download URLs.
ARG TSMUXER_URL=https://github.com/justdan96/tsMuxer/archive/refs/tags/${TSMUXER_VERSION}.tar.gz

# Get Dockerfile cross-compilation helpers.
FROM --platform=$BUILDPLATFORM tonistiigi/xx AS xx

# Build tsMuxeR.
FROM --platform=$BUILDPLATFORM alpine:3.20 AS tsmuxer
ARG TARGETPLATFORM
ARG TSMUXER_VERSION
ARG TSMUXER_URL
COPY --from=xx / /
COPY src/tsmuxer /build
RUN /build/build.sh "$TSMUXER_VERSION" "$TSMUXER_URL"
RUN xx-verify \
    /tmp/tsmuxer-install/usr/bin/tsmuxer \
    /tmp/tsmuxer-install/usr/bin/tsMuxerGUI

# Pull base image.
FROM jlesage/baseimage-gui:alpine-3.20-v4.6.7

ARG TSMUXER_VERSION
ARG DOCKER_IMAGE_VERSION

# Define working directory.
WORKDIR /tmp

# Install dependencies.
RUN add-pkg \
        qt5-qtbase-x11 \
        qt5-qtmultimedia \
        adwaita-qt \
        # A font is needed.
        font-croscore

# Generate and install favicons.
RUN \
    APP_ICON_URL=https://raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/tsmuxer-icon.png && \
    install_app_icon.sh "$APP_ICON_URL"

# Add files.
COPY rootfs/ /
COPY --from=tsmuxer /tmp/tsmuxer-install/usr/bin/tsmuxer /usr/bin/
COPY --from=tsmuxer /tmp/tsmuxer-install/usr/bin/tsMuxerGUI /usr/bin/

# Set internal environment variables.
RUN \
    set-cont-env APP_NAME "tsMuxeR" && \
    set-cont-env APP_VERSION "$TSMUXER_VERSION" && \
    set-cont-env DOCKER_IMAGE_VERSION "$DOCKER_IMAGE_VERSION" && \
    true

# Define mountable directories.
VOLUME ["/storage"]

# Metadata.
LABEL \
      org.label-schema.name="tsmuxer" \
      org.label-schema.description="Docker container for tsMuxeR" \
      org.label-schema.version="${DOCKER_IMAGE_VERSION:-unknown}" \
      org.label-schema.vcs-url="https://github.com/jlesage/docker-tsmuxer" \
      org.label-schema.schema-version="1.0"
