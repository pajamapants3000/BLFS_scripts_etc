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
#kdelibs-4.14.10
# End Required
# Begin Recommended
#kactivities-4.13.3
#kfilemetadata-4.14.3
#baloo-4.14.3
#baloo_widgets-4.14.3
# End Recommended
# Begin Optional
#html_tidy_cvs-20101110
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
grep kde_baseapps-15.04.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/kde-baseapps-15.04.3.tar.xz
# md5sum:
echo "c35e5cf08e0f1111adbfd0c7cac6b01b kde-baseapps-15.04.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kde-baseapps-15.04.3.tar.xz
cd kde-baseapps-15.04.3
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
# Test:
make test
#
as_root make install
cd ../..
as_root rm -rf kde-baseapps-15.04.3
#
# Add to installed list for this computer:
echo "kde_baseapps-15.04.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################