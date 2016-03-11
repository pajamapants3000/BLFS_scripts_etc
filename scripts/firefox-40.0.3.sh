#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source ${HOME}/.blfs_profile
#
# Notes
#*******
# Several errors came up when compiling, all related to libevent. Commenting
#+the relevant line in mozconfig so that firefox uses the built-in version,
#+since my more recent libevent-2.0.22 must not be compatible.
# Is this still relevent? Try going back to system libevent.
#
# Dependencies
#**************
# Begin Required
#alsa_lib-1.0.29
#gtk+-2.24.28
#nss-3.20
#unzip-6.0
#yasm-1.3.0
#zip-3.0 
# End Required
# Begin Recommended
#icu-55.1
#libevent-2.0.22
#libvpx-1.4.0
#sqlite-3.8.11.1 
# End Recommended
# Begin Optional
#curl-7.44.0
#dbus_glib-0.104
#doxygen-1.8.10
#gst_plugins_base-1.4.5
#gst_plugins_good-1.4.5
#gst_libav-1.4.5
#libnotify-0.7.6
#libproxy
#openjdk-1.8.0.45
#pulseaudio-6.0
#startup_notification-0.12
#valgrind-3.10.1
#wget-1.16.3
#wireless tools-29
#hunspell
#liboauth
# End Optional
# Begin Kernel
# End Kernel
#
source ${HOME}/.blfs_profile
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "firefox-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/40.0.3/source/firefox-40.0.3.source.tar.bz2
# md5sum:
echo "26a64a80cbd5b77d3b0d9734bff5bbad firefox-40.0.3.source.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf firefox-40.0.3.source.tar.bz2
pushd mozilla-release
cp -v ../files/mozconfig ./
sed -i '/^ftglyph.h/ i ftfntfmt.h' config/system-headers
make -j${PARALLEL} -f client.mk
as_root make -j${PARALLEL} -f client.mk install INSTALL_SDK=
as_root chown -R 0:0 /usr/lib/firefox-40.0.3
as_root mkdir -pv /usr/lib/mozilla/plugins
as_root ln -sfv ../../mozilla/plugins /usr/lib/firefox-40.0.3/browser
popd
as_root rm -rf mozilla-release
#
# Add to installed list for this computer:
echo "firefox-40.0.3" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
#
as_root mkdir -pv /usr/share/applications
as_root mkdir -pv /usr/share/pixmaps
as_root tee /usr/share/applications/firefox.desktop << "EOF"
[Desktop Entry]
Encoding=UTF-8
Name=Firefox Web Browser
Comment=Browse the World Wide Web
GenericName=Web Browser
Exec=firefox %u
Terminal=false
Type=Application
Icon=firefox
Categories=GNOME;GTK;Network;WebBrowser;
MimeType=application/xhtml+xml;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
EOF
as_root ln -sfv /usr/lib/firefox-40.0.3/browser/icons/mozicon128.png \
        /usr/share/pixmaps/firefox.png
###################################################
