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
#gst_plugins_base-1.4.5
#libxfce4ui-4.12.1
# End Required
# Begin Recommended
#libnotify-0.7.6
#taglib-1.9.1
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep parole-0.8.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/apps/parole/0.8/parole-0.8.0.tar.bz2
# md5sum:
echo "fffdc23d2aa22271f01410a9e27c3404 parole-0.8.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf parole-0.8.0.tar.bz2
cd parole-0.8.0
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf parole-0.8.0
#
# Add to installed list for this computer:
echo "parole-0.8.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################