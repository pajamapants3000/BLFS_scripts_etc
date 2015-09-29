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
#gegl-0.2.0
#gtk+-2.24.28
# End Required
# Begin RecommendedPyGTK-2.24.0 (including the gtk and pango modules)
# End Recommended
# Begin Optional
#aalib-1.4rc5
#alsa_lib-1.0.29
#curl-7.44.0
#dbus_glib-0.104
#ghostscript-9.16 (with libgs installed)
#gvfs-1.24.2
#iso codes-3.59
#jasper-1.900.1
#little_cms-1.19
#little_cms-2.7
#libexif-0.6.21
#libgudev-230
#libmng-2.0.3
#librsvg-2.40.10
#libwmf
#poppler-0.35.0
#mta
#webkitgtk+-2.4.9 (required for the help_plugin)
#gtk_doc-1.24
#pngnq
#pngcrush  
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "gimp-2.8.14" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.gimp.org/pub/gimp/v2.8/gimp-2.8.14.tar.bz2
# md5sum:
echo "233c948203383fa078434cc3f8f925cb gimp-2.8.14.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional help files download:
#wget http://download.gimp.org/pub/gimp/help/gimp-help-2.8.2.tar.bz2
#
# md5sum:
echo "a591c8974b2f4f584d0a769d52ed6c5b gimp-help-2.8.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional patch download
#wget http://www.linuxfromscratch.org/patches/blfs/svn/gimp-2.8.14-device_info-1.patch
#
tar -xvf gimp-2.8.14.tar.bz2
cd gimp-2.8.14
#
patch -Np1 -i ../gimp-2.8.14-device_info-1.patch
#
./configure --prefix=/usr --sysconfdir=/etc --without-gvfs
make
# Test (requires an x-windowed terminal):
make check
#
as_root make install
#
# Install the optional gimp-help package
ALL_LINGUAS="ca da de el en en_GB es fr it ja ko nl nn pt_BR ru sl sv zh_CN" \
./configure --prefix=/usr
make
as_root make install
as_root chown -R root:root /usr/share/gimp/2.0/help
#
if (cat /list-$CHRISTENED"-"$SURNAME | grep gtk+ > /dev/null); then
gtk-update-icon-cache
fi
if (cat /list-$CHRISTENED"-"$SURNAME | grep "desktop_file_utils" > /dev/null); then
update-desktop-database
fi
#
cd ..
as_root rm -rf gimp-2.8.14
#
# Add to installed list for this computer:
echo "gimp-2.8.14" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Configuration
# Change default browser to something other than firefox
#echo '(web-browser "<browser> %s")' >> /etc/gimp/2.0/gimprc
#
###################################################
