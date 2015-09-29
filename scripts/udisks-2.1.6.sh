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
#libatasmart-0.19
#libgudev-230
#libxslt-1.1.28
#polkit-0.113 
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gobject_introspection-1.44.0
#gptfdisk-1.0.0
#gtk_doc-1.24
#ntfs_3g-2015.3.14
#parted-3.2
#dosfstools
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep udisks-2.1.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://udisks.freedesktop.org/releases/udisks-2.1.6.tar.bz2
#
# md5sum:
echo "ea181c13c43af039fded88f0ef546e24 udisks-2.1.6.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf udisks-2.1.6.tar.bz2
cd udisks-2.1.6
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf udisks-2.1.6
#
# Add to installed list for this computer:
echo "udisks-2.1.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################