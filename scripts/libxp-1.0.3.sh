#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libxp-1.0.3
#
# Dependencies
#**************
# Begin Required
#printproto-1.0.5
# End Required
# Begin Recommended
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
grep "libxp-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.x.org/releases/individual/lib/libXp-1.0.3.tar.gz
# md5sum:
#echo "XXX libXp-1.0.3.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libXp-1.0.3.tar.gz
cd libXp-1.0.3
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf libXp-1.0.3
#
# Add to installed list for this computer:
echo "libxp-1.0.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################


