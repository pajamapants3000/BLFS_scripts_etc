#!/bin/bash -ev
# Beyond Linux From Scratch
# Main run - 08 - alt
# Installation script for lynx-2.8.8rel2
# Time: 0.3 SBU
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#gpm-1.20.7
#openssl-1.0.1i
# End Recommended
# Begin Optional
#openssl-1.0.1i
#gnutls-3.3.7
#zip-3.0
#unzip-6.0
#mta
#sharutils-4.14
# End Optional
#
# Check for previous installation:
PROCEED="yes"
grep lynx-2.8.8rel2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://lynx.isc.org/current/lynx2.8.8rel.2.tar.bz2
# md5sum:
echo "b231c2aa34dfe7ca25681ef4e55ee7e8 lynx2.8.8rel.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lynx2.8.8rel.2.tar.bz2
cd lynx2-8-8
./configure --prefix=/usr          \
            --sysconfdir=/etc/lynx \
            --datadir=/usr/share/doc/lynx-2.8.8rel.2 \
            --with-zlib            \
            --with-bzlib           \
            --with-screen=ncursesw \
            --enable-locale-charset
make
as_root make install-full
as_root chgrp -v -R root /usr/share/doc/lynx-2.8.8rel.2/lynx_doc
# Configuration:
as_root sed -i 's/#\(LOCALE_CHARSET\):FALSE/\1:TRUE/' /etc/lynx/lynx.cfg
as_root sed -i 's/#\(DEFAULT_EDITOR\):/\1:vi/' /etc/lynx/lynx.cfg
as_root sed -i 's/#\(PERSISTENT_COOKIES\):FALSE/\1:TRUE/' /etc/lynx/lynx.cfg
cd ..
as_root rm -rf lynx2-8-8
# Config Files
# /etc/lynx/lynx.cfg
# Add to list of installed programs on this system
echo "lynx-2.8.8rel2" >> /list-$CHRISTENED"-"$SURNAME
#