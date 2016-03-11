#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source ${HOME}/.blfs_profile
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#glib-2.44.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "fribidi-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://fribidi.org/download/fribidi-0.19.7.tar.bz2
# md5sum:
echo "6c7e7cfdd39c908f7ac619351c1c5c23 fribidi-0.19.7.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf fribidi-0.19.7.tar.bz2
pushd fribidi-0.19.7
sed -i "s|glib/gstrfuncs\.h|glib.h|" charset/fribidi-char-sets.c
sed -i "s|glib/gmem\.h|glib.h|"      lib/mem.h
./configure --prefix=/usr 
make -j${PARALLEL}
# Test:
make -j${PARALLEL} check
#
as_root make -j${PARALLEL} install
popd
as_root rm -rf fribidi-0.19.7
#
# Add to installed list for this computer:
echo "fribidi-0.19.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

