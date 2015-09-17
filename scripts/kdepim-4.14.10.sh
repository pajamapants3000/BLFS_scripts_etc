#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kdepim-4.14.10
#
# Dependencies
#**************
# Begin Required
#kdepimlibs-4.14.10
#boost-1.59.0
#grantlee-0.5.1
#kdepim_runtime-4.14.10
# End Required
# Begin Recommended
#libassuan-2.3.0
# End Recommended
# Begin Optional
#nepomuk_widgets
#prison
#dblatex
#linkgrammar
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kdepim-4.14.10 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/kdepim-4.14.10.tar.xz
# md5sum:
echo "a09c9bd838cd71c16e9993e57653a7ad kdepim-4.14.10.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kdepim-4.14.10.tar.xz
cd kdepim-4.14.10
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DSYSCONF_INSTALL_DIR=/etc         \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf kdepim-4.14.10
#
# Add to installed list for this computer:
echo "kdepim-4.14.10" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

