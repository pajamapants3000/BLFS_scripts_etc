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
grep "lxqt_notificationd-0.9.0" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/lxqt/0.9.1/lxqt-notificationd-0.9.0.tar.xz
# md5sum:
echo "11d8e306c0b2e23a4cca312cdcb54dbd lxqt-notificationd-0.9.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lxqt-notificationd-0.9.0.tar.xz
cd lxqt-notificationd-0.9.0
sed -e '/QDebug/ i #include <QObject>' \
    -e 's:<KF5/KWindowSystem/:<:'      \
    -i src/notification.cpp
sed -e '/LXQt\/Notification/ i  #include <QObject>' \
    -i config/basicsettings.cpp
#
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
as_root rm -rf lxqt-notificationd-0.9.0
#
# Add to installed list for this computer:
echo "lxqt_notificationd-0.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
