#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libcanberra-0.30
#
# Dependencies
#**************
# Begin Required
#libvorbis-1.3.4
# End Required
# Begin Recommended
#alsa_lib-1.0.28
#gstreamer-1.4.5
#gtk+-3.14.8 
# End Recommended
# Begin Optional
#gtk+-2.24.26
#gtk_doc-1.21
#pulseaudio-5.0
#tdb
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libcanberra-0.30 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://0pointer.de/lennart/projects/libcanberra/libcanberra-0.30.tar.xz
# md5sum:
echo "34cb7e4430afaf6f447c4ebdb9b42072 libcanberra-0.30.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libcanberra-0.30.tar.xz
cd libcanberra-0.30
./configure --prefix=/usr --disable-oss
make
#
as_root make docdir=/usr/share/doc/libcanberra-0.30 install
cd ..
as_root rm -rf libcanberra-0.30
#
# Add to installed list for this computer:
echo "libcanberra-0.30" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
