#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for re2c-0.14.3
#
source blfs_profile
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
grep "re2c-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/re2c/files/re2c/0.14.3/re2c-0.14.3.tar.gz
# md5sum:
echo "9d6914369494ea924a1dd7d96715cdc0 re2c-0.14.3.tar.gz" | md5sum -c ;\
        ( exit ${PIPESTATUS[0]} )
#
tar -xvf re2c-0.14.3.tar.gz
cd re2c-0.14.3
./configure --prefix=/usr
make -j${PARALLEL}
#
rm -f scanner.cc
#
as_root make -j${PARALLEL} install
cd ..
as_root rm -rf re2c-0.14.3
#
# Add to installed list for this computer:
echo "re2c-0.14.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################


