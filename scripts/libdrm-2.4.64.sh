#!/bin/bash -ev
# Beyond Linux From Scratch
# Updated 07/20/2015
# Installation script for libdrm-2.4.64
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#Xorg Libraries
# End Recommended
# Begin Optional
#docbook_xml-4.5
#docbook_xsl-1.78.1
#libxslt-1.1.28
#valgrind-3.10.1 (not recognized by this version...?)
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "libdrm-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://dri.freedesktop.org/libdrm/libdrm-2.4.64.tar.bz2
# md5sum:
echo "543b2d28359cf33974fa0e772dd61732 libdrm-2.4.64.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libdrm-2.4.64.tar.bz2
cd libdrm-2.4.64
sed -e "/pthread-stubs/d" -i configure.ac
autoreconf -fiv
./configure --prefix=/usr --enable-udev --disable-valgrind
make
# Test (may hang for unknown reasons):
#make check
#
as_root make install
cd ..
as_root rm -rf libdrm-2.4.64
#
# Add to installed list for this computer:
echo "libdrm-2.4.64" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################