#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libmng-2.0.3
#
# Dependencies
#**************
# Begin Required
#libjpeg_turbo-1.4.1
#little_cms-2.7 
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
grep libmng-2.0.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/libmng/libmng-2.0.3.tar.xz
# md5sum:
echo "e9e899adb1b681b17f14d91e261878c5 libmng-2.0.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libmng-2.0.3.tar.xz
cd libmng-2.0.3
./configure --prefix=/usr --disable-static
make
#
as_root make install
as_root install -v -m755 -d        /usr/share/doc/libmng-2.0.3
as_root install -v -m644 doc/*.txt /usr/share/doc/libmng-2.0.3
cd ..
as_root rm -rf libmng-2.0.3
#
# Add to installed list for this computer:
echo "libmng-2.0.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################