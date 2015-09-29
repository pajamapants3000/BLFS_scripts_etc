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
#libfm_extra-1.2.3
#liblxqt-0.9.0
#lxmenu_data-0.1.4
# End Required
# Begin Recommended
#oxygen_icons-15.04.3
# End Recommended
# Begin Optional
#A different icon set in place or addition to oxygen_icons
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep pcmanfm_qt-0.9.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/lxqt/0.9.1/pcmanfm-qt-0.9.0.tar.xz
#
# md5sum:
echo "b0ce100b4380ad1a47926a3465aeb6e9 pcmanfm-qt-0.9.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pcmanfm-qt-0.9.0.tar.xz
cd pcmanfm-qt-0.9.0
mkdir -v build
cd       build
cmake -DCMAKE_BUILD_TYPE=Release       \
      -DCMAKE_INSTALL_PREFIX=/opt/lxqt \
      -DCMAKE_INSTALL_LIBDIR=lib       \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf pcmanfm-qt-0.9.0
#
# Add to installed list for this computer:
echo "pcmanfm_qt-0.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
