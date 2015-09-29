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
#docbook_xml-4.5
#python-2.7.10
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
grep "itstool-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://files.itstool.org/itstool/itstool-2.0.2.tar.bz2
# md5sum:
echo "d472d877a7bc49899a73d442085b2f93 itstool-2.0.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf itstool-2.0.2.tar.bz2
cd itstool-2.0.2
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf itstool-2.0.2
#
# Add to installed list for this computer:
echo "itstool-2.0.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
