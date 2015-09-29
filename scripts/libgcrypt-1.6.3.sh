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
#libgpg_error-1.20
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#libcap-2.24
#pth-2.0.7
#texlive-20150521
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libgcrypt-1.6.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.gnupg.org/gcrypt/libgcrypt/libgcrypt-1.6.3.tar.bz2
# md5sum:
echo "4262c3aadf837500756c2051a5c4ae5e libgcrypt-1.6.3.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libgcrypt-1.6.3.tar.bz2
cd libgcrypt-1.6.3
# --with-capabilities : enable libcap2 support
./configure --prefix=/usr --with-capabilities
make
#
# texlive alt docs
#make -j1 -C doc pdf ps html
#makeinfo --html --no-split -o doc/gcrypt_nochunks.html doc/gcrypt.texi
#makeinfo --plaintext       -o doc/gcrypt.txt           doc/gcrypt.texi
# Test:
make check
#
as_root make install
as_root install -v -dm755   /usr/share/doc/libgcrypt-1.6.3
as_root install -v -m644    README doc/{README.apichanges,fips*,libgcrypt*} \
                    /usr/share/doc/libgcrypt-1.6.3
# texlive alt docs install
#as_root install -v -dm755   /usr/share/doc/libgcrypt-1.6.3/html
#as_root install -v -m644 doc/gcrypt.html/* \
#                    /usr/share/doc/libgcrypt-1.6.3/html
#as_root install -v -m644 doc/gcrypt_nochunks.html \
#                    /usr/share/doc/libgcrypt-1.6.3
#as_root install -v -m644 doc/gcrypt.{pdf,ps,dvi,txt,texi} \
#                    /usr/share/doc/libgcrypt-1.6.3
cd ..
as_root rm -rf libgcrypt-1.6.3
#
# Add to installed list for this computer:
echo "libgcrypt-1.6.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
