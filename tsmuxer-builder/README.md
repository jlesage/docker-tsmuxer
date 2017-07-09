# tsMuxeR Self-Contained Version Builder

This builder produces a tarball containing all files and dependencies needed to
run tsMuxeR (both the GUI and CLI).  The only required dependency is the
presence of a X server on the same machine.

Because distributed binaries are built againt GLIBC, tsMuxeR cannot be executed
easily on distributions like Alpine Linux, where `musl` libc implementation is
used.

This self-contained version allows running tsMuxeR on most Linux distributions,
including on Alpine Linux.

tsMuxeR is getting old and only 32-bit binaries are available.  For some reason,
patchelf is crashing when trying to set the interpreter or the rpath of the
binaries, making the final package not as self-container as it could be.

Thus, a link to the 32-bit interpreter needs to be installed to the standard
location.  Also, `LD_LIBRARY_PATH` is needed to make binaries use the right
libraries.  Wrappers are provided to help hiding usage of this variable.

## Building

The build the package, simply run the `run.sh` script, without any argument.

The build is done inside a Docker container.  Thus, Docker must be installed on
your system.

At the end, `tsmuxer.tar.gz` will be produced in the same directory as the
script.
