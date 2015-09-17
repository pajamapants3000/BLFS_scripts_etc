#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xinit-1.3.4
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#twm-1.0.8
#xclock-1.0.7
#xterm-314
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xinit-1.3.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xorg.freedesktop.org/releases/individual/app/xinit-1.3.4.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.x.org/pub/individual/app/xinit-1.3.4.tar.bz2
#
# md5sum:
echo "4e928452dfaf73851413a2d8b8c76388 xinit-1.3.4.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xinit-1.3.4.tar.bz2
cd xinit-1.3.4
./configure $XORG_CONFIG \
            --with-xinitdir=/etc/X11/app-defaults
make
#
as_root make install
cd ..
as_root rm -rf xinit-1.3.4
#
# Add to installed list for this computer:
echo "xinit-1.3.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################