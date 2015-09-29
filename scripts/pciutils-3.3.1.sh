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
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep pciutils-3.3.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget --no-check-certificate \
    https://ftp.kernel.org/pub/software/utils/pciutils/pciutils-3.3.1.tar.xz
# FTP/alt Download:
#wget ftp://ftp.kernel.org/pub/software/utils/pciutils/pciutils-3.3.1.tar.xz
#
# md5sum:
echo "4c340a317987d61a11ee2cf139ef1191 pciutils-3.3.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pciutils-3.3.1.tar.xz
cd pciutils-3.3.1
make PREFIX=/usr              \
     SHAREDIR=/usr/share/misc \
     SHARED=yes
#
as_root make PREFIX=/usr      \
     SHAREDIR=/usr/share/misc \
     SHARED=yes               \
     install install-lib
as_root chmod -v 755 /usr/lib/libpci.so
#
cd ..
as_root rm -rf pciutils-3.3.1
#
# Add to installed list for this computer:
echo "pciutils-3.3.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
