#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for python_distutils_extra-2.38
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
grep "python_distutils_extra-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://launchpad.net/python-distutils-extra/trunk/2.38/+download/python-distutils-extra-2.38.tar.gz
# md5sum:
#echo "XXX python-distutils-extra-2.38.tar.xz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf python-distutils-extra-2.38.tar.xz
cd python-distutils-extra-2.38
python3 ./setup.py build
as_root python3 ./setup.py install --prefix=/usr
cd ..
as_root rm -rf python-distutils-extra-2.38
#
# Add to installed list for this computer:
echo "python_distutils_extra-2.38" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#

