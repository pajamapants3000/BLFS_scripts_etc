#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source enlightenment.sh
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
grep "python_efl-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.enlightenment.org/rel/bindings/python/python-efl-1.15.0.tar.gz
# md5sum:
#echo "XXX python-efl-1.15.0.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf python-efl-1.15.0.tar.gz
cd python-efl-1.15.0
python3 ./setup.py build
as_root -E python3 ./setup.py install --prefix=$ENL_PREFIX
#
as_root ldconfig
#
cd ..
as_root rm -rf python-efl-1.15.0
#
# Add to installed list for this computer:
echo "python_efl-1.15.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

