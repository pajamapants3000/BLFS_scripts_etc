#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for lxqt_policykit-0.9.0
#
# Dependencies
#**************
# Begin Required
#liblxqt-0.9.0
#polkit_qt_1-0.112.0-qt5
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
grep lxqt_policykit-0.9.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/lxqt/0.9.1/lxqt-policykit-0.9.0.tar.xz
#
# md5sum:
echo "15f8f12465d9475ca15562431a21bf38 lxqt-policykit-0.9.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lxqt-policykit-0.9.0.tar.xz
cd lxqt-policykit-0.9.0
mkdir -v build
cd       build
cmake -DCMAKE_BUILD_TYPE=Release       \
      -DCMAKE_INSTALL_PREFIX=/opt/lxqt \
      -DKF5WindowSystem_DIR=/opt/kf5/lib/cmake/KF5WindowSystem \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf lxqt-policykit-0.9.0
#
# Add to installed list for this computer:
echo "lxqt_policykit-0.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
