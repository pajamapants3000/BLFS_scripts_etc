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
#libxfce4util-4.12.1
#libxfce4ui-4.12.1
#gtk+-3.16.6
#gtk+-2.24.28
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
grep garcon-0.5.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/garcon/0.5/garcon-0.5.0.tar.bz2
# md5sum:
echo "68e1deb0a4b7d84182140ddcb84d9065 garcon-0.5.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf garcon-0.5.0.tar.bz2
cd garcon-0.5.0
./configure --prefix=/usr --sysconfdir=/etc
make
#
as_root make install
cd ..
as_root rm -rf garcon-0.5.0
#
# Add to installed list for this computer:
echo "garcon-0.5.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################