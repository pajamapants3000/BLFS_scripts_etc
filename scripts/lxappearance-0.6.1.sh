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
#gtk+-2.24.28
# End Required
# Begin Recommended
#dbus_glib-0.104
# End Recommended
# Begin Optional
#libxslt-1.1.28
#docbook_xml-4.5
#docbook_xsl-1.78.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep lxappearance-0.6.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/lxde/lxappearance-0.6.1.tar.xz
# md5sum:
echo "79740125628a8374c1101cf26e558fa5 lxappearance-0.6.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lxappearance-0.6.1.tar.xz
cd lxappearance-0.6.1
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static  \
            --enable-dbus
make
#
as_root make install
cd ..
as_root rm -rf lxappearance-0.6.1
#
# Add to installed list for this computer:
echo "lxappearance-0.6.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################