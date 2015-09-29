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
#libexif-0.6.21
#pcmanfm_qt-0.9.0
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
grep "lximage_qt-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/lximage-qt/0.4.0/lximage-qt-0.4.0.tar.xz
# md5sum:
echo "0bd2c6474d8d9c73b606e81647e777f0 lximage-qt-0.4.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lximage-qt-0.4.0.tar.xz
cd lximage-qt-0.4.0
sed -i 's/1%/%1/' src/translations/lximage-qt_pt_BR.ts
sed -i 's/Utility;//' data/lximage-qt.desktop.in
mkdir build
cd    build
LDFLAGS="-L${QT5DIR}/lib -L${LXQT_PREFIX}/lib" cmake -DCMAKE_BUILD_TYPE=Release            \
      -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} \
      ..
make
#
as_root make install
if (cat /list-${CHRISTENED}-${SURNAME} | grep xdg_utils > /dev/null); then
    as_root xdg-icon-resource forceupdate --theme hicolor
fi
cd ../..
as_root rm -rf lximage-qt-0.4.0
#
# Add to installed list for this computer:
echo "lximage_qt-0.4.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#

