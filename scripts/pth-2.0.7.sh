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
grep pth-2.0.7 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnu.org/gnu/pth/pth-2.0.7.tar.gz
# FTP/alt Download:
#wget ftp://ftp.gnu.org/gnu/pth/pth-2.0.7.tar.gz
#
# md5sum:
echo "9cb4a25331a4c4db866a31cbe507c793 pth-2.0.7.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pth-2.0.7.tar.gz
cd pth-2.0.7
sed -i 's#$(LOBJS): Makefile#$(LOBJS): pth_p.h Makefile#' Makefile.in
./configure --prefix=/usr           \
            --disable-static        \
            --mandir=/usr/share/man
make
# Test:
make test
#
as_root make install
as_root install -v -m755 -d /usr/share/doc/pth-2.0.7
as_root install -v -m644    README PORTING SUPPORT TESTS \
                    /usr/share/doc/pth-2.0.7
cd ..
as_root rm -rf pth-2.0.7
#
# Add to installed list for this computer:
echo "pth-2.0.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################