#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for qtermwidget-0.6.0
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
#qt-5.5.0
#qt-4.8.7
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
grep "qtermwidget-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://github.com/qterminal/qtermwidget/releases/download/0.6.0/qtermwidget-0.6.0.tar.xz
# md5sum:
echo "763ce418ef6b7167cea6c01e3a97f5f4 qtermwidget-0.6.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf qtermwidget-0.6.0.tar.xz
cd qtermwidget-0.6.0
mkdir build
cd    build
cmake -DCMAKE_BUILD_TYPE=Release  \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_INSTALL_LIBDIR=lib  \
      -DBUILD_DESIGNER_PLUGIN=0   \
      -DUSE_QT5=true              \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf qtermwidget-0.6.0
#
# Add to installed list for this computer:
echo "qtermwidget-0.6.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#

