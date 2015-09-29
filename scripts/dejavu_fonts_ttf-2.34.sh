#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Check for previous installation:
PROCEED="yes"
grep dejavu_fonts_ttf-2.34 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/dejavu/files/dejavu/2.34/dejavu-fonts-ttf-2.34.tar.bz2
# md5sum:
echo "161462de16e2ca79873bc2b0d2e6c74c dejavu-fonts-ttf-2.34.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
tar -xvf dejavu-fonts-ttf-2.34.tar.bz2
cd dejavu-fonts-ttf-2.34
as_root install -v -d -m755 /usr/share/fonts/dejavu
as_root install -v -m644 ttf/*.ttf /usr/share/fonts/dejavu
as_root fc-cache -v /usr/share/fonts/dejavu
cd ..
as_root rm -rf dejavu-fonts-ttf-2.34
# Add to list of installed programs on this system
echo "dejavu_fonts_ttf-2.34" >> /list-$CHRISTENED"-"$SURNAME
#