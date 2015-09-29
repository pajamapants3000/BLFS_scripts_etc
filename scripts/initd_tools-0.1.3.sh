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
grep initd_tools-0.1.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://people.freedesktop.org/~dbn/initd-tools/releases/initd-tools-0.1.3.tar.gz
# md5sum:
echo "ab6377700ace81ec5a556ebdbae1d8d9 initd-tools-0.1.3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf initd-tools-0.1.3.tar.gz
cd initd-tools-0.1.3
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf initd-tools-0.1.3
#
# Add to installed list for this computer:
echo "initd_tools-0.1.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################