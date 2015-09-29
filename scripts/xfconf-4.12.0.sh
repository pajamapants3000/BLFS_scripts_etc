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
#libxfce4util-4.12.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gtk_doc-1.24
#--glib
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xfconf-4.12.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/xfconf/4.12/xfconf-4.12.0.tar.bz2
# md5sum:
echo "8ebfac507b4d6ce3f4bac9d257c2853b xfconf-4.12.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xfconf-4.12.0.tar.bz2
cd xfconf-4.12.0
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf xfconf-4.12.0
#
# Add to installed list for this computer:
echo "xfconf-4.12.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################