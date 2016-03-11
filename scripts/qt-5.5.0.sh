#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Important note: This build is VERY memory intensive. It seems there should
#+be ~2GB RAM per process. To be on the safe side, if you're not sure just do
#+"make -j1" or set PARALLEL=1.
#
# Dependencies
#**************
# Begin Required
#Xorg Libraries
# End Required
# Begin Recommended
#alsa_lib-1.0.29
#certdata
#cups-2.0.4
#d_bus-1.8.18
#glib-2.44.1
#gst_plugins_base-1.4.5
#icu-55.1
#jasper-1.900.1
#libjpeg_turbo-1.4.1
#libmng-2.0.3
#libpng-1.6.18
#tiff-4.0.5
#libwebp-0.4.3
#mesa-10.6.1
#mtdev-1.1.5
#openssl-1.0.2d
#pcre-8.37
#sqlite-3.8.11.1
#ruby-2.2.3
#xcb_util_image-0.4.0
#xcb_util_keysyms-0.4.0
#xcb_util_renderutil-0.3.9
#xcb_util_wm-0.4.1
# End Recommended
# Begin Optional
#geoclue-0.12.0
#gst_plugins_base-1.4.5
#gtk+-2.24.28
#harfbuzz-1.0.2
#ibus
#libxkbcommon
#mariadb-10.0.20
#mysql
#postgresql-9.4.4
#pulseaudio-6.0
#unixodbc-2.3.2
# End Optional
# Begin Kernel
# End Kernel
#
source ${HOME}/.blfs_profile
# For lower RAM systems, uncomment this:
#PARALLEL=1
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep qt-5.5.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.qt.io/archive/qt/5.5/5.5.0/single/qt-everywhere-opensource-src-5.5.0.tar.xz
# md5sum:
echo "65d5282f3dee0336da9ed1f77148952f qt-everywhere-opensource-src-5.5.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf qt-everywhere-opensource-src-5.5.0.tar.xz
cd qt-everywhere-opensource-src-5.5.0
export QT5PREFIX=/opt/qt5
# Create a versioned link to the Qt5 folder:
as_root mkdir /opt/qt-5.5.0
as_root ln -sfnv qt-5.5.0 /opt/qt5
#
./configure -prefix     $QT5PREFIX  \
            -sysconfdir /etc/xdg \
            -confirm-license     \
            -opensource          \
            -dbus-linked         \
            -openssl-linked      \
            -system-harfbuzz     \
            -system-sqlite       \
            -nomake examples     \
            -no-rpath            \
            -skip qtwebengine    \
            -optimized-qmake
make -j$PARALLEL
#
as_root make -j$PARALLEL install
find $QT5PREFIX/lib/pkgconfig -name "*.pc" -exec sudo perl -pi -e "s, -L$PWD/?\S+,,g" {} \;
find $QT5PREFIX -name qt_lib_bootstrap_private.pri \
   -exec sudo sed -i -e "s:$PWD/qtbase:/$QT5PREFIX/lib/:g" {} \;
find $QT5PREFIX -name \*.prl \
   -exec sudo sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' {} \;
# This variable may not stick with as_root...
QT5BINDIR=$QT5PREFIX/bin
as_root install -v -dm755 /usr/share/pixmaps/
as_root install -v -Dm644 qttools/src/assistant/assistant/images/assistant-128.png \
                  /usr/share/pixmaps/assistant-qt5.png
as_root install -v -Dm644 qttools/src/designer/src/designer/images/designer.png \
                  /usr/share/pixmaps/designer-qt5.png
as_root install -v -Dm644 qttools/src/linguist/linguist/images/icons/linguist-128-32.png \
                  /usr/share/pixmaps/linguist-qt5.png
as_root install -v -Dm644 qttools/src/qdbus/qdbusviewer/images/qdbusviewer-128.png \
                  /usr/share/pixmaps/qdbusviewer-qt5.png
as_root install -dm755 /usr/share/applications
as_root tee /usr/share/applications/assistant-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 Assistant 
Comment=Shows Qt5 documentation and examples
Exec=$QT5BINDIR/assistant
Icon=assistant-qt5.png
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;Documentation;
EOF
as_root tee /usr/share/applications/designer-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 Designer
GenericName=Interface Designer
Comment=Design GUIs for Qt5 applications
Exec=$QT5BINDIR/designer
Icon=designer-qt5.png
MimeType=application/x-designer;
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;
EOF
as_root tee /usr/share/applications/linguist-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 Linguist
Comment=Add translations to Qt5 applications
Exec=$QT5BINDIR/linguist
Icon=linguist-qt5.png
MimeType=text/vnd.trolltech.linguist;application/x-linguist;
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;
EOF
as_root tee /usr/share/applications/qdbusviewer-qt5.desktop << EOF
[Desktop Entry]
Name=Qt5 QDbusViewer 
GenericName=D-Bus Debugger
Comment=Debug D-Bus applications
Exec=$QT5BINDIR/qdbusviewer
Icon=qdbusviewer-qt5.png
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;Debugger;
EOF
for file in moc uic rcc qmake lconvert lrelease lupdate; do
  as_root ln -sfrvn $QT5BINDIR/$file /usr/bin/$file-qt5
done
#
as_root tee -a /etc/ld.so.conf << EOF
# Begin Qt addition
#
/opt/qt5/lib
#
# End Qt addition
EOF
as_root ldconfig
#
# Create QT5 environment
as_root cp -v ../files/etc/profile.d/qt5.sh /etc/profile.d/
as_root chown root:root /etc/profile.d/qt5.sh
as_root chmod 755 /etc/profile.d/qt5.sh
[ -f /etc/profile.d/active/60-*.sh ] &&
  as_root rm /etc/profile.d/active/60-*.sh || ( exit 0 )
as_root ln -sv /etc/profile.d/qt5.sh /etc/profile.d/active/60-qt.sh

#
# Add scripts to manage different versions (QT4 and QT5)
for file in setqt4 setqt5 loadqt4 loadqt5; do
  as_root cp -fv ../files/usr/bin/${file} /usr/bin/
  as_root chown root:root /usr/bin/${file}
  as_root chmod 755 /usr/bin/${file}
done
#
cd ..
as_root rm -rf qt-everywhere-opensource-src-5.5.0
#
# Add to installed list for this computer:
echo "qt-5.5.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
