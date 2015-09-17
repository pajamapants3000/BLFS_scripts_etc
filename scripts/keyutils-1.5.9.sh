#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for keyutils-1.5.9
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
grep keyutils-1.5.9 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://people.redhat.com/~dhowells/keyutils/keyutils-1.5.9.tar.bz2
# md5sum:
echo "7f8ac985c45086b5fbcd12cecd23cf07 keyutils-1.5.9.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf keyutils-1.5.9.tar.bz2
cd keyutils-1.5.9
make
#
as_root make NO_ARLIB=1 install
cd ..
as_root rm -rf keyutils-1.5.9
#
# Add to installed list for this computer:
echo "keyutils-1.5.9" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################