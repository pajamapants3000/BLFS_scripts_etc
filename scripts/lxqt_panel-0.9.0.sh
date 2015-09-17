#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for lxqt_panel-0.9.0
#
# Dependencies
#**************
# Begin Required
#lxqt_globalkeys-0.9.0
#liblxqt-0.9.0
#liblxqt_mount-0.9.0
#lxmenu_data-0.1.4
#menu_cache-1.0.0
# End Required
# Begin Recommended
#kguiaddons
#kwindowsystem
#alsa_lib-1.0.29
#pulseaudio-6.0
#libstatgrab-0.91
#libsysstat-0.3.0
#lm_sensors-3.4.0
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
grep lxqt_panel-0.9.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.lxqt.org/lxqt/0.9.1/lxqt-panel-0.9.0.tar.xz
#
# md5sum:
echo "cdae5a811c68fe8162230f1e9ef765f2 lxqt-panel-0.9.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lxqt-panel-0.9.0.tar.xz
cd lxqt-panel-0.9.0
sed -i 's:<KF5/KWindowSystem/:<:'             \
       plugin-mainmenu/lxqtmainmenu.cpp       \
       plugin-kbindicator/lxqtkbindicator.h   \
       plugin-showdesktop/showdesktop.cpp     \
       plugin-taskbar/lxqttaskbutton.cpp      \
       plugin-taskbar/lxqttaskbar.h           \
       plugin-desktopswitch/desktopswitch.cpp \
       panel/lxqtpanel.cpp                    \
       panel/config/configpaneldialog.cpp
sed -e 's:<KF5/KGuiAddons/:<:'                \
    -i plugin-kbindicator/lxqtkbindicator.h
mkdir -v build
cd       build
cmake -DCMAKE_BUILD_TYPE=Release       \
      -DCMAKE_INSTALL_PREFIX=/opt/lxqt \
      -DCMAKE_INSTALL_LIBDIR=lib       \
      -DKF5WindowSystem_DIR=/opt/kf5/lib/cmake/KF5WindowSystem \
      -DKF5GuiAddons_DIR=/opt/kf5/lib/cmake/KF5GuiAddons \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf lxqt-panel-0.9.0
#
# Add to installed list for this computer:
echo "lxqt_panel-0.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#

