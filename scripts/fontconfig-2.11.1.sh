#!/bin/bash -ev
# Beyond Linux From Scratch 7.7
# Installation script for fontconfig-2.11.1
#
# Dependencies
#**************
# Begin Required
#freetype-2.5.5
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#docbook_utils-0.6.14
#libxml2-2.9.2
#texlive-20140525
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep fontconfig-2.11.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.11.1.tar.bz2
# md5sum:
echo "824d000eb737af6e16c826dd3b2d6c90 fontconfig-2.11.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf fontconfig-2.11.1.tar.bz2
cd fontconfig-2.11.1
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-docs       \
            --docdir=/usr/share/doc/fontconfig-2.11.1
make
# Test:
make check
#
as_root make install
as_root install -v -dm755 \
        /usr/share/{man/man{3,5},doc/fontconfig-2.11.1/fontconfig-devel}
as_root install -v -m644 fc-*/*.1          /usr/share/man/man1
as_root install -v -m644 doc/*.3           /usr/share/man/man3
as_root install -v -m644 doc/fonts-conf.5  /usr/share/man/man5
as_root install -v -m644 doc/fontconfig-devel/* \
        /usr/share/doc/fontconfig-2.11.1/fontconfig-devel
as_root install -v -m644 doc/*.{pdf,sgml,txt,html} \
       /usr/share/doc/fontconfig-2.11.1
cd ..
as_root rm -rf fontconfig-2.11.1
#
# Add to installed list for this computer:
echo "fontconfig-2.11.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################