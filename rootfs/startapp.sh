#!/bin/sh
# NOTE: The $HOME variable is set only to have a default location when opening
#       the file dialog window.
#exec env QT_X11_NO_MITSHM=1 HOME="/storage" /opt/tsmuxer/tsMuxerGUI
exec env HOME="/storage" /usr/bin/tsMuxerGUI
# vim:ft=sh:ts=4:sw=4:et:sts=4
