#!/bin/bash
# Begin /etc/profile.d/xorg.sh
XORG_PREFIX="/usr"
XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static"
export XORG_PREFIX XORG_CONFIG
# End /etc/profile.d/xorg.sh