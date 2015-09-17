#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kdev_python-1.7.1-py3
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
grep kdev_python-1.7.1-py3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://mirrors-usa.go-parts.com/kde/stable/kdevelop/4.7.1/src/kdev-python-1.7.1-py3.tar.xz
# FTP/alt Download:
#wget http://ftp.ussg.iu.edu/kde/stable/kdevelop/4.7.1/src/kdev-python-1.7.1-py3.tar.xz
#
# md5sum:
echo "f670af81e55bbc68fd3bd0443b0fc34e kdev-python-1.7.1-py3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kdev-python-1.7.1-py3.tar.xz
cd kdev-python-1.7.1-py3
mkdir -v build
cd       build
cmake -DCMAKE_INSTALL_PREFIX=/opt/kdevelop4 ..
#
as_root make install
cd ../..
as_root rm -rf kdev-python-1.7.1-py3
#
# Add to installed list for this computer:
echo "kdev_python-1.7.1-py3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
