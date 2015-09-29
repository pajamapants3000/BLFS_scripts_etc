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
grep libmbim-1.12.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.freedesktop.org/software/libmbim/libmbim-1.12.2.tar.xz
#
# md5sum:
#echo "XXX libmbim-1.12.2.tar.xz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libmbim-1.12.2.tar.xz
cd libmbim-1.12.2
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libmbim-1.12.2
#
# Add to installed list for this computer:
echo "libmbim-1.12.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
