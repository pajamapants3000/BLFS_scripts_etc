#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libgusb-0.2.6
#
# Dependencies
#**************
# Begin Required
#libusb-1.0.19
# End Required
# Begin Recommended
#gobject_introspection-1.44.0
#vala-0.28.1
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
grep libgusb-0.2.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://people.freedesktop.org/~hughsient/releases/libgusb-0.2.6.tar.xz
# md5sum:
echo "eae30027dfad4dd30f77d8ed8d85b40e libgusb-0.2.6.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libgusb-0.2.6.tar.gz
cd libgusb-0.2.6
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libgusb-0.2.6
#
# Add to installed list for this computer:
echo "libgusb-0.2.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

