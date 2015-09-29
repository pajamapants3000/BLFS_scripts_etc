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
#harfbuzz-1.0.2
#libpng-1.6.18
#which-2.21
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
grep freetype-2.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/freetype/freetype-2.6.tar.bz2
# md5sum:
echo "5682890cb0267f6671dd3de6eabd3e69 freetype-2.6.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Doc download:
wget http://downloads.sourceforge.net/freetype/freetype-doc-2.6.tar.bz2
# md5sum:
echo "f456b7ead3c351c7c218bb3afd45803c freetype-doc-2.6.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf freetype-2.6.tar.bz2
cd freetype-2.6
tar -xf ../freetype-doc-2.6.tar.bz2 --strip-components=2 -C docs
sed -i  -e "/AUX.*.gxvalid/s@^# @@" \
        -e "/AUX.*.otvalid/s@^# @@" \
        modules.cfg
sed -ri -e 's:.*(#.*SUBPIXEL.*) .*:\1:' \
        include/config/ftoption.h
./configure --prefix=/usr --disable-static 
make
# Test:
make check
#
as_root make install
as_root install -v -m755 -d /usr/share/doc/freetype-2.6
as_root cp -v -R docs/*     /usr/share/doc/freetype-2.6
cd ..
as_root rm -rf freetype-2.6
#
# Add to installed list for this computer:
echo "freetype-2.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
