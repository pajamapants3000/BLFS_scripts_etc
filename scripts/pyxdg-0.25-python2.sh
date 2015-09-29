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
#python-2.7.9
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
grep pyxdg-0.25-python2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://people.freedesktop.org/~takluyver/pyxdg-0.25.tar.gz
# md5sum:
echo "bedcdb3a0ed85986d40044c87f23477c pyxdg-0.25.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pyxdg-0.25.tar.gz
cd pyxdg-0.25
#
as_root python setup.py install --optimize=1
cd ..
as_root rm -rf pyxdg-0.25
#
# Add to installed list for this computer:
echo "pyxdg-0.25-python2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################