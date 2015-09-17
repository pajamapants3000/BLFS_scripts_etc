#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libxfce4util-4.12.1
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
grep libxfce4util-4.12.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/libxfce4util/4.12/libxfce4util-4.12.1.tar.bz2
# md5sum:
echo "4eb012b6c1292ceedb3a83ebfc1ff08d libxfce4util-4.12.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libxfce4util-4.12.1.tar.bz2
cd libxfce4util-4.12.1
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf libxfce4util-4.12.1
#
# Add to installed list for this computer:
echo "libxfce4util-4.12.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
