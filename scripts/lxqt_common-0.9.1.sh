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
#liblxqt-0.9.0
#openbox-3.6.1
#qt-5.5.0 (built with librsvg-2.40.10)
#xdg_utils-1.1.0_rc3
# End Required
# Begin Recommended
#consolekit-0.4.6
#lxdm-0.5.0 (or another display manager e.g. sddm)
#desktop_file_utils-0.22
#hicolor_icon_theme-0.15
#shared_mime_info-1.4
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
grep "lxqt_common-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/lxqt/0.9.1/lxqt-common-0.9.1.tar.xz
# md5sum:
echo "7db547d46c4e4e5efb6b3ee8e4a90ad9 lxqt-common-0.9.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lxqt-common-0.9.1.tar.xz
cd lxqt-common-0.9.1
mkdir -v build
cd       build
cmake -DCMAKE_BUILD_TYPE=Release       \
      -DCMAKE_INSTALL_PREFIX=/opt/lxqt \
      -DKF5WindowSystem_DIR=/opt/kf5/lib/cmake/KF5WindowSystem \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf lxqt-common-0.9.1
#
# Add to installed list for this computer:
echo "lxqt_common-0.9.1" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Configuration
#***************
#
#
if (cat /list-$CHRISTENED-$SURNAME | grep "shared_mime_info" > /dev/null); then
    as_root update-mime-database /usr/share/mime
fi
if (cat /list-$CHRISTENED-$SURNAME | grep "hicolor_icon_theme" > /dev/null); then
    as_root xdg-icon-resource forceupdate --theme hicolor
fi
if (cat /list-$CHRISTENED-$SURNAME | grep "desktop_file_utils" > /dev/null); then
    as_root update-desktop-database -q
fi
#
###################################################
