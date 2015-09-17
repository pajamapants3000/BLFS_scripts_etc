#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xkeyboard_config-2.15
#
# Dependencies
#**************
# Begin Required
#Xorg Libraries
# End Required
# Begin Recommended
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
grep xkeyboard_config-2.15 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-2.15.tar.bz2
# FTP/alt Download:
#wget  ftp://ftp.x.org/pub/individual/data/xkeyboard-config/xkeyboard-config-2.15.tar.bz2
#
# md5sum:
echo "4af1deeb7c5f4cad62e65957d98d6758 xkeyboard-config-2.15.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xkeyboard-config-2.15.tar.bz2
cd xkeyboard-config-2.15
./configure $XORG_CONFIG --with-xkb-rules-symlink=xorg
make
#
as_root make install
cd ..
as_root rm -rf xkeyboard-config-2.15
#
# Add to installed list for this computer:
echo "xkeyboard_config-2.15" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################