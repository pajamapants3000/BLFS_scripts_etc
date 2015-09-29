#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
#dbus-glib-0.104
#gconf-3.2.6
#libxslt-1.1.28 
# End Required
# Begin Recommended
#libsoup-2.48.1
#networkmanager-1.0.0 
# End Recommended
# Begin Optional
#gpsd
#gtk+-2.24.26
#ofono
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep geoclue-0.12.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://launchpad.net/geoclue/trunk/0.12/+download/geoclue-0.12.0.tar.gz
# md5sum:
echo "33af8307f332e0065af056ecba65fec2 geoclue-0.12.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Patch to work with GPSD
#wget http://www.linuxfromscratch.org/patches/blfs/7.7/geoclue-0.12.0-gpsd_fix-1.patch
tar -xvf geoclue-0.12.0.tar.gz
cd geoclue-0.12.0
#patch -Np1 -i ../geoclue-0.12.0-gpsd_fix-1.patch
sed -i "s@ -Werror@@" configure
sed -i "s@libnm_glib@libnm-glib@g" configure
sed -i "s@geoclue/libgeoclue.la@& -lgthread-2.0@g" \
       providers/skyhook/Makefile.in
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf geoclue-0.12.0
#
# Add to installed list for this computer:
echo "geoclue-0.12.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################