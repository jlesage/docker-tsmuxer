# Docker container for tsMuxeR
[![Docker Image Size](https://img.shields.io/microbadger/image-size/jlesage/tsmuxer)](http://microbadger.com/#/images/jlesage/tsmuxer) [![Build Status](https://drone.le-sage.com/api/badges/jlesage/docker-tsmuxer/status.svg)](https://drone.le-sage.com/jlesage/docker-tsmuxer) [![GitHub Release](https://img.shields.io/github/release/jlesage/docker-tsmuxer.svg)](https://github.com/jlesage/docker-tsmuxer/releases/latest) [![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://paypal.me/JocelynLeSage/0usd)

This is a Docker container for [tsMuxeR](http://forum.doom9.org/showthread.php?t=168539).

The GUI of the application is accessed through a modern web browser (no installation or configuration needed on the client side) or via any VNC client.

---

[![tsMuxeR logo](https://images.weserv.nl/?url=raw.githubusercontent.com/jlesage/docker-templates/master/jlesage/images/tsmuxer-icon.png&w=200)](http://forum.doom9.org/showthread.php?t=168539)[![tsMuxeR](https://dummyimage.com/400x110/ffffff/575757&text=tsMuxeR)](http://forum.doom9.org/showthread.php?t=168539)

tsMuxer is a Transport Stream muxer. Remux/mux elementary streams, EVO/VOB/MPG,
MKV/MKA, MP4/MOV, TS, M2TS to TS to M2TS. Supported video codecs H.264, VC-1,
MPEG2. Supported audio codecs AAC, AC3 / E-AC3(DD+), DTS/ DTS-HD. Ability to set
muxing fps manually and automatically, change level for H.264 streams, shift
sound tracks, extract DTS core from DTS-HD, join files. Output/author to
compliant Blu-ray Disc or AVCHD.  Blu-ray 3D support.

---

## Quick Start

**NOTE**: The Docker command provided in this quick start is given as an example
and parameters should be adjusted to your need.

Launch the tsMuxeR docker container with the following command:
```
docker run -d \
    --name=tsmuxer \
    -p 5800:5800 \
    -v /docker/appdata/tsmuxer:/config:rw \
    -v $HOME:/storage:rw \
    jlesage/tsmuxer
```

Where:
  - `/docker/appdata/tsmuxer`: This is where the application stores its configuration, log and any files needing persistency.
  - `$HOME`: This location contains files from your host that need to be accessible by the application.

Browse to `http://your-host-ip:5800` to access the tsMuxeR GUI.
Files from the host appear under the `/storage` folder in the container.

## Documentation

Full documentation is available at https://github.com/jlesage/docker-tsmuxer.

## Support or Contact

Having troubles with the container or have questions?  Please
[create a new issue].

For other great Dockerized applications, see https://jlesage.github.io/docker-apps.

[create a new issue]: https://github.com/jlesage/docker-tsmuxer/issues
