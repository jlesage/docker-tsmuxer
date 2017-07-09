#!/bin/sh
SCRIPT_DIR="$(readlink -f "$(dirname "$0")")"
BUILDER_DOCKER_IMAGE="ubuntu:xenial"

DOCKER_CMD="/builder/build.sh /output"

if [ "$1" = "bash" ]; then
    DOCKER_EXTRA_OPTS="-ti --privileged"
    DOCKER_CMD="bash"
fi

exec docker run --rm $DOCKER_EXTRA_OPTS \
    -v "$SCRIPT_DIR:/output" \
    -v "$SCRIPT_DIR/builder:/builder:ro" \
    "$BUILDER_DOCKER_IMAGE" $DOCKER_CMD
