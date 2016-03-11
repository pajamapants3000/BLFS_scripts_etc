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
#alsa_lib-1.0.29
#mesa-10.6.5
#certdata
#d_bus-1.8.18
#glib-2.44.1
#icu-55.1
#libjpeg_turbo-1.4.1
#libmng-2.0.3
#libpng-1.6.18
#tiff-4.0.5
#openssl-1.0.2d
#sqlite-3.8.11.1
# End Recommended
# Begin Optional
#cups-2.0.4
#gtk+-2.24.28
#gst_plugins_base-1.4.5
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
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep qt-4.8.7 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.qt-project.org/official_releases/qt/4.8/4.8.7/qt-everywhere-opensource-src-4.8.7.tar.gz
# md5sum:
echo "d990ee66bf7ab0c785589776f35ba6ad qt-everywhere-opensource-src-4.8.7.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Recommended download
wget http://download.kde.org/stable/qtwebkit-2.3/2.3.4/src/qtwebkit-2.3.4.tar.gz
# md5sum:
echo "42ef76d0cf7d0c611ef83418e9f297ff qtwebkit-2.3.4.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Recommended patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/qtwebkit-2.3.4-gcc5-1.patch
#
tar -xvf qt-everywhere-opensource-src-4.8.7.tar.gz
cd qt-everywhere-opensource-src-4.8.7
export QT4PREFIX=/opt/qt4
as_root mkdir /opt/qt-4.8.7
as_root ln -sfnv qt-4.8.7 /opt/qt4
./configure -prefix           $QT4PREFIX \
            -sysconfdir       /etc/xdg   \
            -confirm-license             \
            -opensource                  \
            -release                     \
            -dbus-linked                 \
            -openssl-linked              \
            -system-sqlite               \
            -no-phonon                   \
            -no-phonon-backend           \
            -no-webkit                   \
            -no-openvg                   \
            -nomake demos                \
            -nomake examples             \
            -optimized-qmake
make -j$PARALLEL
# Test:
make check
#
as_root make -j$PARALLEL install
as_root rm -rf $QT4PREFIX/tests
for file in $QT4PREFIX/lib/libQt*.prl; do
     sudo sed -r -e '/^QMAKE_PRL_BUILD_DIR/d'    \
            -e 's/(QMAKE_PRL_LIBS =).*/\1/' \
            -i $file
done
# Link to new directories
as_root tee -a /etc/ld.so.conf << EOF
# Begin Qt addition
#   
/opt/qt4/lib
#   
# End Qt addition
EOF
as_root /sbin/ldconfig
#
# Create QT4 environment
as_root cp -v ../files/etc/profile.d/qt4.sh /etc/profile.d/
as_root chown root:root /etc/profile.d/qt4.sh
as_root chmod 755 /etc/profile.d/qt4.sh
[ -f /etc/profile.d/active/60-*.sh ] &&
  as_root rm /etc/profile.d/active/60-*.sh || ( exit 0 )
as_root ln -sv /etc/profile.d/qt4.sh /etc/profile.d/active/60-qt.sh
#
source /etc/profile.d/qt4.sh
# Build qtwebkit
mkdir qtwebkit-2.3.4
cd    qtwebkit-2.3.4
tar -xf ../../qtwebkit-2.3.4.tar.gz
patch -Np1 -i ../../qtwebkit-2.3.4-gcc5-1.patch
# Make sure qmake is on PATH and other environment vars are set for
#+WebKit build which needs them!
#
Tools/Scripts/build-webkit --makeargs=-j$PARALLEL \
                           --qt --no-webkit2 --prefix=$QT4PREFIX
as_root make -j$PARALLEL -C WebKitBuild/Release install
#
cd ..
# Follow up
QT4BINDIR=$QT4PREFIX/bin
as_root install -v -Dm644 src/gui/dialogs/images/qtlogo-64.png \
                  /usr/share/pixmaps/qt4logo.png
as_root install -v -Dm644 tools/assistant/tools/assistant/images/assistant-128.png \
                  /usr/share/pixmaps/assistant-qt4.png
as_root install -v -Dm644 tools/designer/src/designer/images/designer.png \
                  /usr/share/pixmaps/designer-qt4.png
as_root install -v -Dm644 tools/linguist/linguist/images/icons/linguist-128-32.png \
                  /usr/share/pixmaps/linguist-qt4.png
as_root install -v -Dm644 tools/qdbus/qdbusviewer/images/qdbusviewer-128.png \
                  /usr/share/pixmaps/qdbusviewer-qt4.png
as_root install -dm755 /usr/share/applications
as_root tee /usr/share/applications/assistant-qt4.desktop << EOF
[Desktop Entry]
Name=Qt4 Assistant 
Comment=Shows Qt4 documentation and examples
Exec=$QT4BINDIR/assistant
Icon=assistant-qt4.png
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;Documentation;
EOF
as_root tee /usr/share/applications/designer-qt4.desktop << EOF
[Desktop Entry]
Name=Qt4 Designer
Comment=Design GUIs for Qt4 applications
Exec=$QT4BINDIR/designer
Icon=designer-qt4.png
MimeType=application/x-designer;
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;
EOF
as_root tee /usr/share/applications/linguist-qt4.desktop << EOF
[Desktop Entry]
Name=Qt4 Linguist 
Comment=Add translations to Qt4 applications
Exec=$QT4BINDIR/linguist
Icon=linguist-qt4.png
MimeType=text/vnd.trolltech.linguist;application/x-linguist;
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;
EOF
as_root tee /usr/share/applications/qdbusviewer-qt4.desktop << EOF
[Desktop Entry]
Name=Qt4 QDbusViewer 
GenericName=D-Bus Debugger
Comment=Debug D-Bus applications
Exec=$QT4BINDIR/qdbusviewer
Icon=qdbusviewer-qt4.png
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Development;Debugger;
EOF
as_root tee /usr/share/applications/qtconfig-qt4.desktop << EOF
[Desktop Entry]
Name=Qt4 Config 
Comment=Configure Qt4 behavior, styles, fonts
Exec=$QT4BINDIR/qtconfig
Icon=qt4logo.png
Terminal=false
Encoding=UTF-8
Type=Application
Categories=Qt;Settings;
EOF
# Create symlinks
for file in moc uic rcc qmake lconvert lrelease lupdate; do
  as_root ln -sfrvn $QT4BINDIR/$file /usr/bin/$file-qt4
done
#
# Add scripts to manage different versions (QT4 and QT5)
for file in setqt4 setqt5 loadqt4 loadqt5; do
  as_root cp -fv ../files/usr/bin/${file} /usr/bin/
  as_root chown root:root /usr/bin/${file}
  as_root chmod 755 /usr/bin/${file}
done
#
cd ..
as_root rm -rf qt-everywhere-opensource-src-4.8.7
#
# Add to installed list for this computer:
echo "qt-4.8.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
