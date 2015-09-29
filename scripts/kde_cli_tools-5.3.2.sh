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
#kcmutils-5.11.0
#kdelibs4support-5.11.0
#kdesu-5.11.0
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
grep kde_cli_tools-5.3.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/plasma/5.3.2/kde-cli-tools-5.3.2.tar.xz
#
# md5sum:
echo "17ec549a653a89c694eb03bbe0d053d2 kde-cli-tools-5.3.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kde-cli-tools-5.3.2.tar.xz
cd kde-cli-tools-5.3.2
mkdir -v build
cd       build
cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -DLIB_INSTALL_DIR=lib              \
      -DBUILD_TESTING=OFF                \
      -DQT_PLUGIN_INSTALL_DIR=lib/qt5/plugins \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf kde-cli-tools-5.3.2
#
as_root ln -sfv ../lib/libexec/kf5/kdesu $KF5_PREFIX/bin/kdesu5
#
# Add to installed list for this computer:
echo "kde_cli_tools-5.3.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#

