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
#attica-0.4.2
#automoc4-0.9.88
#docbook_xml-4.5
#docbook_xsl-1.78.1
#giflib-5.1.1
#libdbusmenu_qt-0.9.3+15.10.20150604
#libjpeg_turbo-1.4.1
#libpng-1.6.18
#phonon-4.8.3
#strigi-0.7.8
#shared_mime_info-1.4
# End Required
# Begin Recommended
#polkit_qt-0.112.0
#openssl-1.0.2d
#qca-2.1.0
#upower-0.9.23
#udisks-1.0.5
#udisks-2.1.6
# End Recommended
# Begin Optional
#jasper-1.900.1
#pcre-8.37
#avahi-0.6.31
#aspell-0.60.6.1
#enchant-1.6.0
#grantlee-0.5.1
#krb5-1.13.2
#soprano
#shared_desktop_ontologies
#hspell
#fam
#hupnp
#openexr
#media_player_info
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kdelibs-4.14.10 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/kdelibs-4.14.10.tar.xz
# md5sum:
echo "68cb7191d8f7ac383cc30bfe69a016bc kdelibs-4.14.10.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kdelibs-4.14.10.tar.xz
cd kdelibs-4.14.10
sed -i "s@{SYSCONF_INSTALL_DIR}/xdg/menus@& RENAME kde-applications.menu@" \
        kded/CMakeLists.txt
sed -i "s@applications.menu@kde-&@" \
        kded/kbuildsycoca.cpp
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DSYSCONF_INSTALL_DIR=/etc         \
      -DCMAKE_BUILD_TYPE=Release         \
      -DDOCBOOKXML_CURRENTDTD_DIR=/usr/share/xml/docbook/xml-dtd-4.5 \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf kdelibs-4.14.10
#
# Add to installed list for this computer:
echo "kdelibs-4.14.10" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################