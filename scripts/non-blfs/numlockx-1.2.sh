#!/bin/bash -ev
# Installation script for numlockx_1.2
#
# Dependencies
#**************
# Begin Required
#Xorg
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
grep numlockx-1.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.de.debian.org/debian/pool/main/n/numlockx/numlockx_1.2.orig.tar.gz
tar -xvf numlockx_1.2.orig.tar.gz
cd numlockx-1.2
./configure --prefix=/usr
# Default is /usr/local, may want to keep that by commenting above line.
make
as_root make install
cd ..
as_root rm -rf numlockx-1.2
# Add to list of installed programs on this system
echo "numlockx-1.2" >> /list-$CHRISTENED"-"$SURNAME
#