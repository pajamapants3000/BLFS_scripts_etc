#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libxcb-1.11
#
# Dependencies
#**************
# Begin Required
#libXau-1.0.8
#xcb-proto-1.11
# End Required
# Begin Recommended
#libXdmcp-1.1.1
# End Recommended
# Begin Optional
#doxygen-1.8.9.1
#check-0.9.14
#libxslt-1.1.28
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libxcb-1.11 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xcb.freedesktop.org/dist/libxcb-1.11.tar.bz2
# FTP/alt Download:
#wget XXX
#
# md5sum:
echo "5a873ebd383d1a60612dd6ec6b42c781 libxcb-1.11.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libxcb-1.11.tar.bz2
cd libxcb-1.11
sed -i "s/pthread-stubs//" configure
./configure $XORG_CONFIG    \
            --enable-xinput \
            --docdir='${datadir}'/doc/libxcb-1.11
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libxcb-1.11
#
# Add to installed list for this computer:
echo "libxcb-1.11" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################