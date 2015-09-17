#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for qtcreator-3.4.2
#
# Dependencies
#**************
# Begin Required
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
source blfs_profile
source setqt5
INSTALL_DIRECTORY=$QT5DIR
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep qtcreator-3.4.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.qt.io/official_releases/qtcreator/3.4/3.4.2/qt-creator-opensource-src-3.4.2.tar.gz
#
# Alt links
#wget http://mirror.os6.org/qtproject/official_releases/qtcreator/3.4/3.4.2/qt-creator-opensource-src-3.4.2.tar.gz
#wget http://qtmirror.ics.com/pub/qtproject/official_releases/qtcreator/3.4/3.4.2/qt-creator-opensource-src-3.4.2.tar.gz
# md5sum:
echo "4a72e361a07576c140d1d67a54b16226 qtcreator-3.4.2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf qtcreator-3.4.2.tar.gz
cd qtcreator-3.4.2
qmake -r
make -j$PARALLEL
#
as_root make -j$PARALLEL install INSTALL_ROOT=$INSTALL_DIRECTORY
cd ..
as_root rm -rf qtcreator-3.4.2
#
# Add to installed list for this computer:
echo "qtcreator-3.4.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
