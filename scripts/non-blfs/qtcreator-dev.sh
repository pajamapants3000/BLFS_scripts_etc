#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
# Requires Qt-5.4.0+; g++ 4.7+
#**************
# Begin Required
#qt-5.5.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
# End Kernel
#
# Preparation (is this the best place to install?)
#**************
source setqt5
INSTALL_DIRECTORY=$QT5DIR
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep qtcreator-dev /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
[ -d $HOME/repo ] || mkdir -pv $HOME/repo
pushd $HOME/repo
# Download:
git clone https://github.com/qtproject/qt-creator.git
pushd qt-creator
qmake -r
make -j5
#
as_root make install INSTALL_ROOT=$INSTALL_DIRECTORY
cd ..
rm -rf qt-creator
#
# Add to installed list for this computer:
echo "qtcreator-dev" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
