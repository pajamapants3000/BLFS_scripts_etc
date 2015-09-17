#!/bin/bash
#
# Begin /etc/profile.d/kde.sh
#

KDE_PREFIX=/opt/kde
KDEDIR=/opt/kde
KDEDIRS=/opt/kde

pathappend /opt/kde/bin			PATH
pathappend /opt/kde/lib/pkgconfig   	PKG_CONFIG_PATH
pathappend /opt/kde/share/pkgconfig 	PKG_CONFIG_PATH
pathappend /opt/kde/share           	XDG_DATA_DIRS
pathappend /opt/kde/share/man       	MANPATH
pathappend /etc/kde/xdg                	XDG_CONFIG_DIRS

export KDE_PREFIX KDEDIR KDEDIRS
export PATH PKG_CONFIG_PATH XDG_DATA_DIRS MANPATH XDG_CONFIG_DIRS

# End /etc/profile.d/kde.sh
