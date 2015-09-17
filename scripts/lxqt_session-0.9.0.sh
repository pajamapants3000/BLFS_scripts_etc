#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for lxqt_session-0.9.0
#
# Dependencies
#**************
# Begin Required
#liblxqt-0.9.0
#lxqt_common-0.9.1
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
grep "lxqt_session-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/lxqt/0.9.1/lxqt-session-0.9.0.tar.xz
# md5sum:
echo "92fca1504bcd61d0c8a761ba3748e81f lxqt-session-0.9.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lxqt-session-0.9.0.tar.xz
cd lxqt-session-0.9.0
patch -p1 < ../patches/lxqt_session-0.9.0.patch
mkdir -v build
cd       build
cmake -DCMAKE_BUILD_TYPE=Release         \
      -DCMAKE_INSTALL_PREFIX=/opt/lxqt   \
      -DKF5_INCLUDE_DIR=/opt/kf5/include \
      -DKF5WindowSystem_DIR=/opt/kf5/lib/cmake/KF5WindowSystem \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf lxqt-session-0.9.0
#
# Add to installed list for this computer:
echo "lxqt_session-0.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
