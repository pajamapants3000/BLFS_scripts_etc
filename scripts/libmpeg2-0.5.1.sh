#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libmpeg2-0.5.1
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#x_window_system
#sdl-1.2.15
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "libmpeg2-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://libmpeg2.sourceforge.net/files/libmpeg2-0.5.1.tar.gz
# FTP/alt Download:
#wget ftp://mirror.ovh.net/gentoo-distfiles/distfiles/libmpeg2-0.5.1.tar.gz
#
# md5sum:
echo "0f92c7454e58379b4a5a378485bbd8ef libmpeg2-0.5.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libmpeg2-0.5.1.tar.gz
cd libmpeg2-0.5.1
sed -i 's/static const/static/' libmpeg2/idct_mmx.c
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
as_root install -v -m755 -d /usr/share/doc/mpeg2dec-0.5.1
as_root install -v -m644 README doc/libmpeg2.txt \
        /usr/share/doc/mpeg2dec-0.5.1
cd ..
as_root rm -rf libmpeg2-0.5.1
#
# Add to installed list for this computer:
echo "libmpeg2-0.5.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

