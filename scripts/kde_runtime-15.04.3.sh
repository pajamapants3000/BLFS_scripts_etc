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
#kdelibs-4.14.10
#libgcrypt-1.6.3
# End Required
# Begin Recommended
#alsa_lib-1.0.29
#exiv2-0.25
#kactivities-4.13.3
#kdepimlibs-4.14.10
#libjpeg-turbo-1.4.1
# End Recommended
# Begin Optional
#libcanberra-0.30
#networkmanager-1.0.6
#pulseaudio-6.0
#samba-4.2.3
#xine_lib-1.2.6
#libssh
#nepomuk_core
#openexr
#openslp
#qntrack
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kde_runtime-15.04.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/kde-runtime-15.04.3.tar.xz
# md5sum:
echo "404af4794ca93cd7fbbb3304a671b629 kde-runtime-15.04.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kde-runtime-15.04.3.tar.xz
cd kde-runtime-15.04.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX         \
      -DSYSCONF_INSTALL_DIR=/etc                  \
      -DCMAKE_BUILD_TYPE=Release                  \
      -DSAMBA_INCLUDE_DIR=/usr/include/samba-4.0 \
      -Wno-dev ..
make
# Test:
make test
#
as_root make install
as_root ln -sfv ../lib/kde4/libexec/kdesu $KDE_PREFIX/bin/kdesu
cd ../..
as_root rm -rf kde-runtime-15.04.3
#
# Add to installed list for this computer:
echo "kde_runtime-15.04.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################