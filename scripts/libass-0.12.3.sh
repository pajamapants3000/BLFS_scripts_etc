#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libass-0.12.3
#
# Dependencies
#**************
# Begin Required
#freetype-2.6
#fribidi-0.19.7 
# End Required
# Begin Recommended
#fontconfig-2.11.1
# End Recommended
# Begin Optional
#harfbuzz-1.0.2
#enca
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "libass-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://anduin.linuxfromscratch.org/sources/other/libass-0.12.3.tar.gz
# md5sum:
echo "1b53e739ab389335ce46fd626777ec61 libass-0.12.3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libass-0.12.3.tar.gz
cd libass-0.12.3
sh autogen.sh
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf libass-0.12.3
#
# Add to installed list for this computer:
echo "libass-0.12.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

