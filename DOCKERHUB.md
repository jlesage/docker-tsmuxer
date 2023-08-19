# Docker container for tsMuxeR
[![Release](https://img.shields.io/github/release/jlesage/docker-tsmuxer.svg?logo=github&style=for-the-badge)](https://github.com/jlesage/docker-tsmuxer/releases/latest)
[![Docker Image Size](https://img.shields.io/docker/image-size/jlesage/tsmuxer/latest?logo=docker&style=for-the-badge)](https://hub.docker.com/r/jlesage/tsmuxer/tags)
[![Docker Pulls](https://img.shields.io/docker/pulls/jlesage/tsmuxer?label=Pulls&logo=docker&style=for-the-badge)](https://hub.docker.com/r/jlesage/tsmuxer)
[![Docker Stars](https://img.shields.io/docker/stars/jlesage/tsmuxer?label=Stars&logo=docker&style=for-the-badge)](https://hub.docker.com/r/jlesage/tsmuxer)
[![Build Status](https://img.shields.io/github/actions/workflow/status/jlesage/docker-tsmuxer/build-image.yml?logo=github&branch=master&style=for-the-badge)](https://github.com/jlesage/docker-tsmuxer/actions/workflows/build-image.yml)
[![Source](https://img.shields.io/badge/Source-GitHub-blue?logo=github&style=for-the-badge)](https://github.com/jlesage/docker-tsmuxer)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg?style=for-the-badge)](https://paypal.me/JocelynLeSage)

This is a Docker container for [tsMuxeR](https://github.com/justdan96/tsMuxer).

The GUI of the application is accessed through a modern web browser (no
installation or configuration needed on the client side) or via any VNC client.

---

[![tsMuxeR logo](https://images.weserv.nl/?url=raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/tsmuxer-icon.png&w=110)](https://github.com/justdan96/tsMuxer)[![tsMuxeR](https://images.placeholders.dev/?width=224&height=110&fontFamily=monospace&fontWeight=400&fontSize=52&text=tsMuxeR&bgColor=rgba(0,0,0,0.0)&textColor=rgba(121,121,121,1))](https://github.com/justdan96/tsMuxer)

tsMuxer is a Transport Stream muxer. Remux/mux elementary streams, EVO/VOB/MPG,
MKV/MKA, MP4/MOV, TS, M2TS to TS to M2TS. Supported video codecs H.264, VC-1,
MPEG2. Supported audio codecs AAC, AC3 / E-AC3(DD+), DTS/ DTS-HD. Ability to set
muxing fps manually and automatically, change level for H.264 streams, shift
sound tracks, extract DTS core from DTS-HD, join files. Output/author to
compliant Blu-ray Disc or AVCHD.  Blu-ray 3D support.

---

## Quick Start

**NOTE**:
    The Docker command provided in this quick start is given as an example
    and parameters should be adjusted to your need.

Launch the tsMuxeR docker container with the following command:
```shell
docker run -d \
    --name=tsmuxer \
    -p 5800:5800 \
    -v /docker/appdata/tsmuxer:/config:rw \
    -v /home/user:/storage:rw \
    jlesage/tsmuxer
```

Where:

  - `/docker/appdata/tsmuxer`: This is where the application stores its configuration, states, log and any files needing persistency.
  - `/home/user`: This location contains files from your host that need to be accessible to the application.

Browse to `http://your-host-ip:5800` to access the tsMuxeR GUI.
Files from the host appear under the `/storage` folder in the container.

## Documentation

Full documentation is available at https://github.com/jlesage/docker-tsmuxer.

## Support or Contact

Having troubles with the container or have questions?  Please
[create a new issue].

For other great Dockerized applications, see https://jlesage.github.io/docker-apps.

[create a new issue]: https://github.com/jlesage/docker-tsmuxer/issues
