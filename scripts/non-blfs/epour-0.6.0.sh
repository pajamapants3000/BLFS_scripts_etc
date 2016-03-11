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
source ${HOME}/.blfs_profile
#
# Dependencies
#**************
# Begin Required
#libtorrent_rasterbar-1.0.6
#python_distutils_extra-2.38
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
grep "epour-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.enlightenment.org/rel/apps/epour/epour-0.6.0.tar.gz
# md5sum:
#echo "XXX epour-0.6.0.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf epour-0.6.0.tar.gz
cd epour-0.6.0
python3 ./setup.py build
as_root python3 ./setup.py install --prefix=$ENL_PREFIX
#
as_root ldconfig
#
cd ..
as_root rm -rf epour-0.6.0
#
# Add to installed list for this computer:
echo "epour-0.6.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
