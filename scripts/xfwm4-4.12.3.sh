#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xfwm4-4.12.3
#
# Dependencies
#**************
# Begin Required
#libwnck-2.30.7
#libxfce4ui-4.12.1
#libxfce4util-4.12.1
# End Required
# Begin Recommended
#startup_notification-0.12
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
grep xfwm4-4.12.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/xfwm4/4.12/xfwm4-4.12.3.tar.bz2
# md5sum:
echo "197ef087ca6a263627f1bea6d5a79d6f xfwm4-4.12.3.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xfwm4-4.12.3.tar.bz2
cd xfwm4-4.12.3
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf xfwm4-4.12.3
#
# Add to installed list for this computer:
echo "xfwm4-4.12.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################