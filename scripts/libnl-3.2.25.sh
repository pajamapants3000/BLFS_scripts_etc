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
# End Recommended
# Begin Optional
#check-0.9.14
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libnl-3.2.25 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.carisma.slowglass.com/~tgr/libnl/files/libnl-3.2.25.tar.gz
#
# md5sum:
echo "03f74d0cd5037cadc8cdfa313bbd195c libnl-3.2.25.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional doc download:
wget http://www.carisma.slowglass.com/~tgr/libnl/files/libnl-doc-3.2.25.tar.gz
#
# md5sum:
echo "641f73052d9f54e720efe1a476a20237 libnl-doc-3.2.25.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libnl-3.2.25.tar.gz
cd libnl-3.2.25
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static
make
# Test:
make check
#
as_root make install
#
# Optional doc download install
as_root mkdir -vp /usr/share/doc/libnl-3.2.25 &&
as_root tar -xf ../libnl-doc-3.2.25.tar.gz --strip-components=1 --no-same-owner \
        -C /usr/share/doc/libnl-3.2.25
#
cd ..
as_root rm -rf libnl-3.2.25
#
# Add to installed list for this computer:
echo "libnl-3.2.25" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
