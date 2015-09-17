#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kdevplatform-1.7.1
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
grep "kdevplatform-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://kde.mirrors.tds.net/pub/kde/stable/kdevelop/4.7.1/src/kdevplatform-1.7.1.tar.xz
# FTP/alt Download:
#wget http://mirrors.mit.edu/kde/stable/kdevelop/4.7.1/src/kdevplatform-1.7.1.tar.xz
#
# md5sum:
echo "f6c123d65ae8d5c50944d548c8bc812f kdevplatform-1.7.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kdevplatform-1.7.1.tar.xz
cd kdevplatform-1.7.1
mkdir -v build
cd       build
cmake -DCMAKE_INSTALL_PREFIX=/opt/kdevelop4 ..
make
#
as_root make install
cd ..
as_root rm -rf kdevplatform-1.7.1
#
# Add to installed list for this computer:
echo "kdevplatform-1.7.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
