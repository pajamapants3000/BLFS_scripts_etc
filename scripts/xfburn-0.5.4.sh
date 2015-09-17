#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xfburn-0.5.4
#
# Dependencies
#**************
# Begin Required
#exo-0.10.6
#libxfce4util-4.12.1
#libisoburn-1.4.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gst_plugins-base-1.4.5
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xfburn-0.5.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/apps/xfburn/0.5/xfburn-0.5.4.tar.bz2
#
# md5sum:
echo "448fcbb7023645216c5a52435a9cf72a xfburn-0.5.4.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xfburn-0.5.4.tar.bz2
cd xfburn-0.5.4
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf xfburn-0.5.4
#
# Add to installed list for this computer:
echo "xfburn-0.5.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################