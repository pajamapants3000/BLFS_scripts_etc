#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kde_frameworks-5.12.0
#
# Dependencies: See list!
#
# Dependencies
#**************
# Begin Required
#boost-1.59.0
#extra_cmake_modules-5.12.0
#docbook_xml-4.5
#docbook_xsl-1.78.1
#giflib-5.1.1
#libepoxy-1.3.1
#libgcrypt-1.6.3
#libjpeg_turbo-1.4.1
#libpng-1.6.18
#libxslt-1.1.28
#phonon-4.8.3
#shared_mime_info-1.4
#wget-1.16.3
# End Required
# Begin Recommended
#avahi-0.6.31
#aspell-0.60.6.1
#libdbusmenu_qt-0.9.3+15.10.20150604
# End Recommended
# Begin Optional
#bluez-5.32
#networkmanager-1.0.6
#modemmanager
#oxygen_fonts
#doxygen-1.8.10
#jinja2
#pyyaml
#jasper-1.900.1
#openexr
#krb5-1.13.2
#modemmanager
#udisks-2.1.6
#upower-0.9.23
#media_player_info
#hspell
#hunspell 
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kde_frameworks-5.12.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
mkdir kf5-build
cd kf5-build
cp -v ../files/frameworks-5.12.0.md5 ./
url=http://download.kde.org/stable/frameworks/5.12/
wget -r -nH --cut-dirs=3 -A '*.xz' -np $url
#
while read -r line; do
    # Get the file name, ignoring comments and blank lines
    if $(echo $line | grep -E -q '^ *$|^#' ); then continue; fi
    file=$(echo $line | cut -d" " -f2)
    pkg=$(echo $file|sed 's|^.*/||')          # Remove directory
    packagedir=$(echo $pkg|sed 's|\.tar.*||') # Package directory
    PROCEED="yes"
    grep $packagedir /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
        echo "Previous installation detected, proceed?" && read PROCEED
    [ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || continue
    tar -xf $file
    pushd $packagedir
      mkdir build
      cd    build
      cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX \
            -DCMAKE_PREFIX_PATH=$QT5DIR        \
            -DCMAKE_BUILD_TYPE=Release         \
            -DLIB_INSTALL_DIR=lib              \
            -DBUILD_TESTING=OFF                \
            -Wno-dev .. 
      make
      as_root make install
  popd
  rm -rf $packagedir
  as_root /sbin/ldconfig
  echo $packagedir >> /list-$CHRISTENED"-"$SURNAME
done < frameworks-5.12.0.md5
#
# Add to installed list for this computer:
echo "kde_frameworks-5.12.0" >> /list-$CHRISTENED"-"$SURNAME
#
# The following packages are left out and can be installed later:
#bluez-qt-5.12.0
#
###################################################
(($REINSTALL)) && exit 0 || (exit 0)
#
# Create a versioned installation
as_root mv -v /opt/kf5 /opt/kf5-5.12.0
as_root ln -sfvn kf5-5.12.0 /opt/kf5
#
##################################################
