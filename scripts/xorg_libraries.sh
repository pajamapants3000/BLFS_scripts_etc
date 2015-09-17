#!/bin/bash -ev
# Beyond Linux From Scratch
# Xorg Libraries
# Installation script for xorg_libraries
#
# Dependencies
#**************
# Begin Required
#fontconfig-2.11.1
#libxcb-1.11
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#xmlto-0.0.26
##fop-1.1
##Links-2.9
#Lynx-2.8.8rel.2
##w3m-0.5.3
# End Optional
# Begin Kernel
# End Kernel
#
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xorg_libraries /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
# This script will download, test, and install all packages.
mkdir lib
cd lib
grep -v '^#' ../lib-7.7.md5 | awk '{print $2}' | wget -i- -c \
    -B http://xorg.freedesktop.org/releases/individual/lib/
md5sum -c ../lib-7.7.md5
for package in $(grep -v '^#' ../lib-7.7.md5 | awk '{print $2}')
do
  packagedir=${package%.tar.bz2}
  tar -xf $package
  pushd $packagedir
  case $packagedir in
    libXfont-[0-9]* )
      ./configure $XORG_CONFIG --disable-devel-docs
    ;;
    libXt-[0-9]* )
      ./configure $XORG_CONFIG \
                  --with-appdefaultdir=/etc/X11/app-defaults
    ;;
    * )
      ./configure $XORG_CONFIG
    ;;
  esac
make
as_root make install
popd
rm -rf $packagedir
as_root /sbin/ldconfig
done
cd ..
as_root rm -rf lib
# Add to list of installed programs on this system
echo "xorg_libraries" >> /list-$CHRISTENED"-"$SURNAME
#
