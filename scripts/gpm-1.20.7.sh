#!/bin/bash -ev
#
# Installation Script
# Main run - 07
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Time: 0.1 SBU
# Check for previous installation:
PROCEED="yes"
grep gpm-1.20.7 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
source blfs_profile
# Download:
wget http://www.nico.schottelius.org/software/gpm/archives/gpm-1.20.7.tar.bz2
# md5sum:
echo "bf84143905a6a903dbd4d4b911a2a2b8 gpm-1.20.7.tar.bz2" | md5sum -c
tar -xvf gpm-1.20.7.tar.bz2
cd gpm-1.20.7
./autogen.sh
./configure --prefix=/usr --sysconfdir=/etc
as_root make install
as_root install-info --dir-file=/usr/share/info/dir           \
             /usr/share/info/gpm.info
as_root ln -sfv libgpm.so.2.1.0 /usr/lib/libgpm.so
as_root install -v -m644 conf/gpm-root.conf /etc
as_root install -v -m755 -d /usr/share/doc/gpm-1.20.7/support
as_root install -v -m644    doc/support/*                     \
                    /usr/share/doc/gpm-1.20.7/support
as_root install -v -m644    doc/{FAQ,HACK_GPM,README*}        \
                    /usr/share/doc/gpm-1.20.7
cd ../blfs-bootscripts-20150823
as_root make install-gpm
as_root tee /etc/sysconfig/mouse << "EOF"
# Begin /etc/sysconfig/mouse

MDEVICE="/dev/input/mice"
PROTOCOL="<yourprotocol>"
GPMOPTS=""

# End /etc/sysconfig/mouse
EOF
cd ..
as_root rm -rf gpm-1.20.7
# Config files:
# /etc/gpm-root.conf and ~/.gpm-root
#
# Extra config steps
# Determine and set PROTOCOL, run
# $gpm -m /dev/input/mice -t -help
as_root sed -i s/"<yourprotocol>"/$MOUSE_PROTOCOL/ /etc/sysconfig/mouse
#
# /dev/input/mice presumes a USB mouse. May need to alter.
# Add to list of installed programs on this system
echo "gpm-1.20.7" >> /list-$CHRISTENED"-"$SURNAME
#
