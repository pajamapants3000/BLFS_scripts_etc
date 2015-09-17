#!/bin/bash -ev
# Beyond Linux From Scratch
# Xorg Fonts
# Installation script for xorg_fonts
# This script will download, test, and install all packages.
#
# Dependencies
#**************
# Begin Required
#xcursor_themes-1.0.4
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
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
grep xorg_fonts /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
mkdir font
cd font
grep -v '^#' ../font-7.7.md5 | awk '{print $2}' | wget -i- -c \
    -B http://xorg.freedesktop.org/releases/individual/font/
md5sum -c ../font-7.7.md5
for package in $(grep -v '^#' ../font-7.7.md5 | awk '{print $2}')
do
  packagedir=${package%.tar.bz2}
  tar -xf $package
  pushd $packagedir
  ./configure $XORG_CONFIG
  make
  as_root make install
  popd
  as_root rm -rf $packagedir
done
as_root install -v -d -m755 /usr/share/fonts
as_root ln -svfn $XORG_PREFIX/share/fonts/X11/OTF /usr/share/fonts/X11-OTF
as_root ln -svfn $XORG_PREFIX/share/fonts/X11/TTF /usr/share/fonts/X11-TTF
cd ..
as_root rm -rf font
# Add to list of installed programs on this system
echo "xorg_fonts" >> /list-$CHRISTENED"-"$SURNAME
#
