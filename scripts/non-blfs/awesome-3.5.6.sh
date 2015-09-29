#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Updated 07/19/2015
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
#libxdg-basedir-1.2.0
#lua-5.3.1
#xcb-util-cursor-0.1.1
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
grep awesome-3.5.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
# Install dependency lgi:
as_root luarocks install lgi
# Download:
wget http://awesome.naquadah.org/download/awesome-3.5.6.tar.xz
#
tar -xvf awesome-3.5.6.tar.xz
pushd awesome-3.5.6
#
# These steps may seem strange, but this is indeed what the documentation
#+advises. Running make creates a build subfolder from which cmake should
#+be run and where the cmake files are - after running make!.
make
cd build
cmake -DCMAKE_INSTALL_PREFIX=/usr .
#
as_root make install
cd ..
as_root cp -v awesome.desktop /usr/share/xsessions/
popd
cp -vR ../files/awsesome ${HOME}/.config/
as_root rm -rf awesome-3.5.6
# Add to list of installed programs on this system
echo "awesome-3.5.6" >> /list-${CHRISTENED}-${SURNAME}
#
