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
#gc-7.4.2
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gpm-1.20.7
#openssl-1.0.2
#imlib2-1.4.6
#gtk+-2.24.26
#imlib
#gdk_pixbuf-2.31.6
#compface-1.5.2
#nkf
#Mail User Agent
#External Browser
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep w3m-0.5.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/w3m/w3m-0.5.3.tar.gz
# md5sum:
echo "1b845a983a50b8dec0169ac48479eacc w3m-0.5.3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/7.7/w3m-0.5.3-bdwgc72-1.patch
tar -xvf w3m-0.5.3.tar.gz
cd w3m-0.5.3
patch -Np1 -i ../w3m-0.5.3-bdwgc72-1.patch
sed -i 's/file_handle/file_foo/' istream.{c,h}
sed -i 's#gdk-pixbuf-xlib-2.0#& x11#' configure
./configure --prefix=/usr --sysconfdir=/etc
make
#
as_root make install
as_root install -v -m644 -D doc/keymap.default /etc/w3m/keymap
as_root install -v -m644    doc/menu.default /etc/w3m/menu
as_root install -v -m755 -d /usr/share/doc/w3m-0.5.3
as_root install -v -m644    doc/{HISTORY,READ*,keymap.*,menu.*,*.html} \
                    /usr/share/doc/w3m-0.5.3
cd ..
as_root rm -rf w3m-0.5.3
#
# Add to installed list for this computer:
echo "w3m-0.5.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################