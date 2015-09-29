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
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
# End Kernel
#
if [ $QTDIR = $QT5DIR ]; then
    source setqt4
    QTMOD=1
fi
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kdevelop_pg_qt-1.0.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/kdevelop-pg-qt/1.0.0/src/kdevelop-pg-qt-1.0.0.tar.bz2
#
# md5sum:
echo "155f4e9a3a6d34ebe756c2a16169706f kdevelop-pg-qt-1.0.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kdevelop-pg-qt-1.0.0.tar.bz2
cd kdevelop-pg-qt-1.0.0
mkdir -v build
cd       build
cmake -DCMAKE_INSTALL_PREFIX=/opt/kdevelop4 ..
#
as_root make install
cd ../..
as_root rm -rf kdevelop-pg-qt-1.0.0
#
# Add to installed list for this computer:
echo "kdevelop_pg_qt-1.0.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

