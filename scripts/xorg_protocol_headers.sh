#!/bin/bash -ve
# Beyond Linux From Scratch
# Installation script for xorg_protocol_headers
#
# Dependencies
#**************
# Begin Required
#sudo-1.8.14p3
#wget-1.16.3
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
grep xorg_protocol_headers /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
# This script will download, test, and install all packages.
mkdir proto
cd proto
grep -v '^#' ../proto-7.7.md5 | awk '{print $2}' | wget -i- -c \
    -B http://xorg.freedesktop.org/releases/individual/proto/
md5sum -c ../proto-7.7.md5
# asroot advised here
for package in $(grep -v '^#' ../proto-7.7.md5 | awk '{print $2}')
do
  packagedir=${package%.tar.bz2}
  tar -xf $package
  pushd $packagedir
  ./configure $XORG_CONFIG
  as_root make install
  popd
  rm -rf $packagedir
done
cd ..
as_root rm -rf proto
# Add to list of installed programs on this system
echo "xorg_protocol_headers" >> /list-$CHRISTENED"-"$SURNAME
#
