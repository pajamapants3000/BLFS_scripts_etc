#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for bzrtools-2.6.0
#
# Dependencies
#**************
# Begin Required
#bzr-2.6.0
#python-2.7.10
# End Required
# Begin Recommended
#rsync-3.1.1
# End Recommended
# Begin Optional
#python-3.4.3
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep bzrtools-2.6.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://launchpad.net/bzrtools/stable/2.6.0/+download/bzrtools-2.6.0.tar.gz
#
tar -xvf bzrtools-2.6.0.tar.gz
cd bzrtools-2.6.0
as_root ./setup.py install --prefix=/usr
cd ..
as_root rm -rf bzrtools-2.6.0
#
# Add to installed list for this computer:
echo "bzrtools-2.6.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################