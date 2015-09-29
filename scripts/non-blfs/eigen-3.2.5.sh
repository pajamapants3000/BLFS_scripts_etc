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
grep "eigen-3.2.5" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://bitbucket.org/eigen/eigen/get/3.2.5.tar.bz2 -O eigen-3.2.5.tar.bz2
# md5sum:
echo "21a928f6e0f1c7f24b6f63ff823593f5 eigen-3.2.5.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
mkdir eigen-3.2.5 &&
    tar -xvf eigen-3.2.5.tar.bz2 -C eigen-3.2.5 --strip-components=1
pushd eigen-3.2.5
mkdir -v build
cd       build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make -j${PARALLEL}
#
as_root make -j${PARALLEL} install
popd
as_root rm -rf eigen-3.2.5
#
# Add to installed list for this computer:
echo "eigen-3.2.5" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
