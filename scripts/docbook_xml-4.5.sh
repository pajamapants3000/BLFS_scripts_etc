#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source blfs_profile
#
# Dependencies
#**************
# Begin Required
#libxml2-2.9.2
#unzip-6.0
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
grep docbook_xml-4.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.docbook.org/xml/4.5/docbook-xml-4.5.zip
# FTP/alt Download:
#wget ftp://mirror.ovh.net/gentoo-distfiles/distfiles/docbook-xml-4.5.zip
#
# md5sum:
echo "03083e288e87a7e829e437358da7ef9e docbook-xml-4.5.zip" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
mkdir docbook-xml-4.5
cd docbook-xml-4.5
unzip ../docbook-xml-4.5.zip
as_root install -v -d -m755 /usr/share/xml/docbook/xml-dtd-4.5
as_root install -v -d -m755 /etc/xml
as_root chown -R root:root .
as_root cp -v -af docbook.cat *.dtd ent/ *.mod \
    /usr/share/xml/docbook/xml-dtd-4.5
cd ..
as_root rm -rf docbook-xml-4.5
#
# Add to installed list for this computer:
echo "docbook_xml-4.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Now su to root and run configuration!
pushd $(dirname $(readlink -nf $0)) &&
su -c "./docbook_xml-4.5-config.sh"
#
###################################################

