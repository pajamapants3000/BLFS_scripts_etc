#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libqmi-1.12.6
#
# Dependencies
#**************
# Begin Required
#glib-2.44.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gtk_doc-1.24
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libqmi-1.12.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.freedesktop.org/software/libqmi/libqmi-1.12.6.tar.xz
#
# md5sum:
#echo "XXX libqmi-1.12.6.tar.xz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libqmi-1.12.6.tar.xz
cd libqmi-1.12.6
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libqmi-1.12.6
#
# Add to installed list for this computer:
echo "libqmi-1.12.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

