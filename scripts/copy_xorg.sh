#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Initial preparation for Xorg installation
cp -v Xorg/* ./
as_root cp -v xorg.sh /etc/profile.d/
as_root chown -v root:root /etc/profile.d/xorg.sh
as_root chmod 644 /etc/profile.d/xorg.sh
as_root ln -sfv /etc/profile.d/xorg.sh /etc/profile.d/active/50-xorg.sh
# Add to list of installed programs on this system
echo "copy-xorg" >> /list-$CHRISTENED"-"$SURNAME
#
