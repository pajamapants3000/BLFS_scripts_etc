#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for check-0.10.0
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
grep "check-0.10.0" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/check/check-0.10.0.tar.gz
# md5sum:
echo "53c5e5c77d090e103a17f3ed7fd7d8b8 check-0.10.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf check-0.10.0.tar.gz
cd check-0.10.0
./configure --prefix=/usr --disable-static
make
# Test - appears to hang a few times, just be patient:
make check
#
as_root make docdir=/usr/share/doc/check-0.10.0 install
cd ..
as_root rm -rf check-0.10.0
#
# Add to installed list for this computer:
echo "check-0.10.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################


