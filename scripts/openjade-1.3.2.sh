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
#opensp-1.5.2
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
grep openjade-1.3.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/openjade/openjade-1.3.2.tar.gz
# md5sum:
echo "7df692e3186109cc00db6825b777201e openjade-1.3.2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/openjade-1.3.2-gcc_4.6-1.patch
tar -xvf openjade-1.3.2.tar.gz
cd openjade-1.3.2
patch -Np1 -i ../openjade-1.3.2-gcc_4.6-1.patch
sed -i -e '/getopts/{N;s#&G#g#;s#do .getopts.pl.;##;}' \
       -e '/use POSIX/ause Getopt::Std;' msggen.pl
./configure --prefix=/usr                                \
            --mandir=/usr/share/man                      \
            --enable-http                                \
            --disable-static                             \
            --enable-default-catalog=/etc/sgml/catalog   \
            --enable-default-search-path=/usr/share/sgml \
            --datadir=/usr/share/sgml/openjade-1.3.2
make
#
as_root make install
as_root make install-man
as_root ln -v -sf openjade /usr/bin/jade
as_root ln -v -sf libogrove.so /usr/lib/libgrove.so
as_root ln -v -sf libospgrove.so /usr/lib/libspgrove.so
as_root ln -v -sf libostyle.so /usr/lib/libstyle.so
as_root install -v -m644 dsssl/catalog /usr/share/sgml/openjade-1.3.2/
as_root install -v -m644 dsssl/*.{dtd,dsl,sgm}              \
    /usr/share/sgml/openjade-1.3.2
as_root install-catalog --add /etc/sgml/openjade-1.3.2.cat  \
    /usr/share/sgml/openjade-1.3.2/catalog
as_root install-catalog --add /etc/sgml/sgml-docbook.cat    \
    /etc/sgml/openjade-1.3.2.cat
#
su -c 'echo "SYSTEM \"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd\" \
    \"/usr/share/xml/docbook/xml-dtd-4.5/docbookx.dtd\"" >> \
    /usr/share/sgml/openjade-1.3.2/catalog'
cd ..
as_root rm -rf openjade-1.3.2
#
# Add to installed list for this computer:
echo "openjade-1.3.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
