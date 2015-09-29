#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
#python-2.7.10
# End Required
# Begin Recommended
# End Recommended
# Begin Optional - All but Bzrtools obtained with pip; included optionally in script below.
#Pyrex
#pycrypto
#paramiko
#Bzrtools
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep bzr-2.6.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
# Install optional dependencies
pip2 install Pyrex pycrypto paramiko
# Download:
wget https://launchpad.net/bzr/2.6/2.6.0/+download/bzr-2.6.0.tar.gz
# md5sum:
echo "28c86653d0df10d202c6b842deb0ea35 bzr-2.6.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf bzr-2.6.0.tar.gz
cd bzr-2.6.0
as_root ./setup.py install --prefix=/usr
cd ..
as_root rm -rf bzr-2.6.0
#
# Add to installed list for this computer:
echo "bzr-2.6.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################