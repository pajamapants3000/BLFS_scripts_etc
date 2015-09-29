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
grep "kdev_python-.*-py2" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://mirrors-usa.go-parts.com/kde/stable/kdevelop/4.7.1/src/kdev-python-1.7.1.tar.xz
# FTP/alt Download:
#wget http://ftp.ussg.iu.edu/kde/stable/kdevelop/4.7.1/src/kdev-python-1.7.1.tar.xz
#
# md5sum:
echo "4f1be4efbfb6c062bed4fbc825d0d079 kdev-python-1.7.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kdev-python-1.7.1.tar.xz
cd kdev-python-1.7.1
cmake -DCMAKE_INSTALL_PREFIX=/opt/kdevelop4 ..
#
as_root make install
cd ../..
as_root rm -rf kdev-python-1.7.1
#
# Add to installed list for this computer:
echo "kdev_python-1.7.1-py2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
