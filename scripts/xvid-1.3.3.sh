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
#yasm-1.3.0
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
grep "xvid-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.xvid.org/downloads/xvidcore-1.3.3.tar.gz
# md5sum:
echo "8ecddfe488cb3a82d792fc7efbf51d62 xvidcore-1.3.3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xvidcore-1.3.3.tar.gz
cd xvidcore
cd build/generic
sed -i 's/^LN_S=@LN_S@/& -f -v/' platform.inc.in
./configure --prefix=/usr
make
#
sudo sed -i '/libdir.*STATIC_LIB/ s/^/#/' Makefile
as_root make install
as_root chmod -v 755 /usr/lib/libxvidcore.so.4.3
as_root install -v -m755 -d /usr/share/doc/xvidcore-1.3.3/examples
as_root install -v -m644 ../../doc/* /usr/share/doc/xvidcore-1.3.3
as_root install -v -m644 ../../examples/* \
    /usr/share/doc/xvidcore-1.3.3/examples
#
cd ../..
as_root rm -rf xvidcore
#
# Add to installed list for this computer:
echo "xvid-1.3.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

