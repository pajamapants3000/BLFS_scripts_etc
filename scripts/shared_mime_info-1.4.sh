#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for shared_mime_info-1.4
#
# Dependencies
#**************
# Begin Required
#glib-2.42.1
#libxml2-2.9.2
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
grep shared_mime_info-1.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://freedesktop.org/~hadess/shared-mime-info-1.4.tar.xz
# md5sum:
echo "16c02f7b658fff2a9c207406d388ea31 shared-mime-info-1.4.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf shared-mime-info-1.4.tar.xz
cd shared-mime-info-1.4
./configure --prefix=/usr
make -j1
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf shared-mime-info-1.4
#
# Add to installed list for this computer:
echo "shared_mime_info-1.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################