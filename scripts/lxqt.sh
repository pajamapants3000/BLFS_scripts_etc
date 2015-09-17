#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for lxqt
#
source blfs_profile
#
# Dependencies
#**************
#
# Set environment!!! At least LXQT_PREFIX.
#
if ! [ ${LXQT_PREFIX} ]; then
    echo "Please set environment before running! Specifically, you"
    echo "must have LXQT_PREFIX set."
    exit
fi
#
# Begin Required
#gtk_doc
#qt5
#kwindowsystem
#kguiaddons
#solid
# compton-conf requires libconfig
# ADD TO LXQT-PURE
#gtk_doc
#libconfig
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
grep "lxqt" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
git clone --recursive http://www.github.com/lxde/lxqt
#
cd lxqt
pushd libqtxdg
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} -DUSE_QT5=ON ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd liblxqt
sed -e '/lxqtnotification.h/ i #include <QObject>' \
    -i lxqtnotification.cpp
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd lxqt-globalkeys
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd lxqt-notificationd
sed -e '/QDebug/ i #include <QObject>' \
    -e 's:<KF5/KWindowSystem/:<:'      \
    -i src/notification.cpp
sed -e '/LXQt\/Notification/ i  #include <QObject>' \
    -i config/basicsettings.cpp
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd libsysstat
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd menu-cache
./autogen.sh
./configure --prefix=${LXQT_PREFIX}
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
# Supposedly not needed/deprecated but panel won't go without it!
pushd liblxqt-mount
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd lxqt-panel
sed -i 's:<KF5/KWindowSystem/:<:'       \
       plugin-mainmenu/lxqtmainmenu.cpp       \
       plugin-kbindicator/lxqtkbindicator.h   \
       plugin-showdesktop/showdesktop.cpp     \
       plugin-taskbar/lxqttaskbutton.cpp      \
       plugin-taskbar/lxqttaskbar.h           \
       plugin-desktopswitch/desktopswitch.cpp \
       panel/lxqtpanel.cpp                    \
       panel/config/configpaneldialog.cpp
sed -e 's:<KF5/KGuiAddons/:<:'          \
    -i plugin-kbindicator/lxqtkbindicator.h
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd pcmanfm-qt
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd lxqt-session
sed -e 's:<KF5/KWindowSystem/:<:' \
    -i lxqt-session/src/lxqtmodman.cpp
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd lxqt-runner
sed -i 's:<KF5/KWindowSystem/:<:' dialog.cpp
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd lxqt-qtplugin
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd lxqt-policykit
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd lxqt-powermanagement
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd lximage-qt
sed -i 's/1%/%1/' src/translations/lximage-qt_pt_BR.ts
sed -i 's/Utility;//' data/lximage-qt.desktop.in
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
LIBRARY_PATH=/opt/qt5/lib:$LXQT_PREFIX/lib make -j${PARALLEL}
as_root make -j${PARALLEL} install
as_root xdg-icon-resource forceupdate --theme hicolor
popd
#####
pushd lxqt-config
sed -i '/<QRect>/ i #include <QObject>' lxqt-config-monitor/monitor.h
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd obconf-qt
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} -DUSE_QT5=ON ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd compton-conf
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} -DUSE_QT5=ON ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd lxqt-about
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
pushd lxqt-common
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=${LXQT_PREFIX} ..
make -j${PARALLEL}
as_root make -j${PARALLEL} install
as_root update-mime-database ${LXQT_PREFIX}/share/mime
as_root xdg-icon-resource forceupdate --theme hicolor
as_root update-desktop-database -q
popd
#####
pushd lxmenu-data
./autogen.sh
./configure --prefix=/usr --sysconfdir=/etc
make -j${PARALLEL}
as_root make -j${PARALLEL} install
popd
#####
#as_root rm -rf lxqt
#
# Add to installed list for this computer:
echo "lxqt" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
