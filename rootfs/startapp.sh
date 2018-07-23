#!/usr/bin/with-contenv sh
# NOTE: The $HOME variable is set only to have a default location when opening
#       the file dialog window.
exec env QT_X11_NO_MITSHM=1 HOME="/storage" /opt/tsmuxer/tsMuxerGUI
