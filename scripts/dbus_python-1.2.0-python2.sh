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
#dbus_glib-0.104
#python-2.7.9
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#epydoc
#docutils
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep dbus_python-1.2.0-python2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://dbus.freedesktop.org/releases/dbus-python/dbus-python-1.2.0.tar.gz
# md5sum:
echo "b09cd2d1a057cc432ce944de3fc06bf7 dbus-python-1.2.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf dbus-python-1.2.0.tar.gz
cd dbus-python-1.2.0
mkdir python2
pushd python2
PYTHON=/usr/bin/python     \
../configure --prefix=/usr --docdir=/usr/share/doc/dbus-python-1.2.0
make
popd
# Test:
make -C python2 check
#
as_root make -C python2 install
cd ..
as_root rm -rf dbus-python-1.2.0
#
# Add to installed list for this computer:
echo "dbus_python-1.2.0-python2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################