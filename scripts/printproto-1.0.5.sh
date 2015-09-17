#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for printproto-1.0.5
#
# Dependencies
#**************
# Begin Required
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
grep "printproto-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.x.org/releases/individual/proto/printproto-1.0.5.tar.gz
# md5sum:
#echo "XXX printproto-1.0.5.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf printproto-1.0.5.tar.gz
cd printproto-1.0.5
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf printproto-1.0.5
#
# Add to installed list for this computer:
echo "printproto-1.0.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################


