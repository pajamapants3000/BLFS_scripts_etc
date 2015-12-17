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
grep plasma-5.3.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
mkdir plasma-build
cd plasma-build
cp -v ../files/plasma-5.3.2.md5 ./
url=http://download.kde.org/stable/plasma/5.3.2/
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
      cmake -DCMAKE_INSTALL_PREFIX=$KF5_PREFIX      \
            -DCMAKE_PREFIX_PATH=$QT5DIR             \
            -DCMAKE_BUILD_TYPE=Release              \
            -DLIB_INSTALL_DIR=lib                   \
            -DBUILD_TESTING=OFF                     \
            -DQT_PLUGIN_INSTALL_DIR=lib/qt5/plugins \
            -DQML_INSTALL_DIR=lib/qt5/qml           \
            -DECM_MKSPECS_INSTALL_DIR=$KF5_PREFIX/share/qt5/mkspecs/modules \
            -DOXYGEN_FONT_INSTALL_DIR=/usr/share/fonts/truetype/oxygen      \
            -Wno-dev ..
      make
      as_root make install
  popd
  as_root rm -rf $packagedir
  if [ ${packagedir:0:13} = kde_cli_tools ]; then
      as_root ln -sfv ../lib/libexec/kf5/kdesu $KF5_PREFIX/bin/kdesu5
  fi
  as_root /sbin/ldconfig
  echo $packagedir >> /list-$CHRISTENED"-"$SURNAME
done < plasma-5.3.2.md5
#
as_root install -Dm644 -g root -o root ../files/etc/pam.d/kde /etc/pam.d/
as_root install -Dm755 -g root -o root ../files/usr/bin/startkde-wrapper \
    $KF5_PREFIX/bin/
# This seems to actually cause problems, not fix anything as far as I can tell.
#sed -i "s:qtpaths:&-qt5:g" $KF5_PREFIX/bin/startkde
install -v -dm755 /usr/share/xsessions
sed -i "s:startkde:&-wrapper:g" $KF5_PREFIX/share/xsessions/plasma.desktop
ln -sfv $KF5_PREFIX/share/xsessions/plasma.desktop /usr/share/xsessions/kf5-plasma.desktop
#
# Add to installed list for this computer:
echo "plasma-5.3.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

