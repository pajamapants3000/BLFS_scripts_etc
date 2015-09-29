#!/bin/bash -ev
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
grep libzip-1.0.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.nih.at/libzip/libzip-1.0.1.tar.xz
#
tar -xvf libzip-1.0.1.tar.xz
cd libzip-1.0.1
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make
#
as_root make install
# Make the include file easier to find for other programs that call
#+libzip as a dependency.
as_root ln -sv ../lib/libzip/include/zipconf.h /usr/include/zipconf.h
cd ../..
as_root rm -rf libzip-1.0.1
#
# Add to installed list for this computer:
echo "libzip-1.0.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
