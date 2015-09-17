#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for elfutils-0.163
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
grep elfutils-0.163 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://fedorahosted.org/releases/e/l/elfutils/0.163/elfutils-0.163.tar.bz2
# md5sum:
echo "77ce87f259987d2e54e4d87b86cbee41 elfutils-0.163.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf elfutils-0.163.tar.bz2
cd elfutils-0.163
./configure --prefix=/usr --program-prefix="eu-"
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf elfutils-0.163
#
# Add to installed list for this computer:
echo "elfutils-0.163" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################