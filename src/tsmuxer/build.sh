#!/bin/sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

# Set same default compilation flags as abuild.
export CFLAGS="-Os -fomit-frame-pointer"
export CXXFLAGS="$CFLAGS"
export CPPFLAGS="$CFLAGS"
export LDFLAGS="-Wl,--strip-all -Wl,--as-needed"

export CC=xx-clang
export CXX=xx-clang++

function log {
    echo ">>> $*"
}

TSMUXER_VERSION="$1"
TSMUXER_URL="$2"

if [ -z "$TSMUXER_VERSION" ]; then
    log "ERROR: tsMuxeR version missing."
    exit 1
fi

if [ -z "$TSMUXER_URL" ]; then
    log "ERROR: tsMuxeR URL missing."
    exit 1
fi

#
# Install required packages.
#
apk --no-cache add \
    curl \
    binutils \
    git \
    clang \
    cmake \
    make \
    pkgconf \
    imagemagick \
    qtchooser \
    qt5-qtbase-dev \
    qt5-qttools-dev \

xx-apk --no-cache --no-scripts add \
    musl-dev \
    gcc \
    g++ \
    zlib-dev \
    freetype-dev \
    qt5-qtbase-dev \
    qt5-qttools-dev \
    qt5-qtmultimedia-dev \

# Make sure tools used to generate code are the ones from the host.
if [ "$(xx-info sysroot)" != "/" ]
then
    ln -sf /usr/bin/moc $(xx-info sysroot)usr/lib/qt5/bin/moc
    ln -sf /usr/bin/uic $(xx-info sysroot)usr/lib/qt5/bin/uic
    ln -sf /usr/bin/rcc $(xx-info sysroot)usr/lib/qt5/bin/rcc
    ln -sf /usr/bin/lrelease $(xx-info sysroot)usr/lib/qt5/bin/lrelease
fi

#
# Download sources.
#

log "Downloading tsMuxeR package..."
mkdir /tmp/tsmuxer
curl -# -L -f ${TSMUXER_URL} | tar xz --strip 1 -C /tmp/tsmuxer

#
# Compile tsMuxeR.
#

# Set the version from commit hash.
GIT_HASH="$(git ls-remote -t https://github.com/justdan96/tsMuxer.git | grep "$TSMUXER_VERSION" | awk '{print $1}' | head -c 8)"
sed -i "s/\${TSMUXER_VERSION}/git-$GIT_HASH/" /tmp/tsmuxer/CMakeLists.txt

log "Configuring tsMuxeR..."
(
    mkdir /tmp/tsmuxer/build && \
    cd /tmp/tsmuxer/build && cmake \
        $(xx-clang --print-cmake-defines) \
        -DCMAKE_FIND_ROOT_PATH=$(xx-info sysroot) \
        -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE=Release \
        -DTSMUXER_GUI=ON \
        ..
)

# Remove embedded profile from PNGs to avoid the "known incorrect sRGB
# profile" warning.
find /tmp/tsmuxer -name "*.png" -exec echo "Removing embedded profiles from {}..." ';' -exec mogrify {} ';'

log "Compiling tsMuxeR..."
make -C /tmp/tsmuxer/build -j$(nproc)

log "Installing tsMuxeR..."
make DESTDIR=/tmp/tsmuxer-install -C /tmp/tsmuxer/build install
