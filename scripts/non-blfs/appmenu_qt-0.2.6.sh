#!/bin/bash -ev
# Installation script for appmenu_qt-0.2.6
#
# Dependencies
#**************
# Begin Required
#qt-4.8.7
#kde_workspace-4.11.21
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
grep appmenu_qt-0.2.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://launchpad.net/appmenu-qt/trunk/0.2.6/+download/appmenu-qt-0.2.6.tar.bz2
# md5sum:
echo "90cce750e5412d43ce075b0a9bdb6782 appmenu-qt-0.2.6.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf appmenu-qt-0.2.6.tar.bz2
cd appmenu-qt-0.2.6
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf appmenu-qt-0.2.6
#
# Add to installed list for this computer:
echo "appmenu_qt-0.2.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################