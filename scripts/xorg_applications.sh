#!/bin/bash -ev
#
# Installation Script
# Xorg Applications
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
#libpng-1.6.16
#mesa-10.6.5
#xbitmaps-1.1.1
#xcb_util-0.4.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#linux_pam-1.1.8
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xorg_applications /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# This script will download, test, and install all packages.
mkdir app
cd app
grep -v '^#' ../app-7.7.md5 | awk '{print $2}' | wget -i- -c \
    -B http://xorg.freedesktop.org/releases/individual/app/
md5sum -c ../app-7.7.md5
for package in $(grep -v '^#' ../app-7.7.md5 | awk '{print $2}')
do
  packagedir=${package%.tar.bz2}
  tar -xf $package
  pushd $packagedir
  case $packagedir in
    luit-[0-9]* )
      line1="#ifdef _XOPEN_SOURCE"
      line2="#  undef _XOPEN_SOURCE"
      line3="#  define _XOPEN_SOURCE 600"
      line4="#endif"
      sed -i -e "s@#ifdef HAVE_CONFIG_H@$line1\n$line2\n$line3\n$line4\n\n&@" sys.c
      unset line1 line2 line3 line4
    ;;
    sessreg-* )
        sed -e 's/\$(CPP) \$(DEFS)/$(CPP) -P $(DEFS)/' -i man/Makefile.in
    ;;
  esac
./configure $XORG_CONFIG
make
as_root make install
popd
rm -rf $packagedir
done
cd ..
as_root rm -rf app
# Add to list of installed programs on this system
echo "xorg_applications" >> /list-$CHRISTENED"-"$SURNAME
#
