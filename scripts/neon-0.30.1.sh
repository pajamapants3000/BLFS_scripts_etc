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
#openssl-1.0.2d
#gnutls-3.4.4.1 
# End Recommended
# Begin Optional
#libxml2-2.9.2
#krb5-1.13.2
#libproxy
#pakchois
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep neon-0.30.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.webdav.org/neon/neon-0.30.1.tar.gz
# md5sum:
echo "231adebe5c2f78fded3e3df6e958878e neon-0.30.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf neon-0.30.1.tar.gz
cd neon-0.30.1
sed -e 's/gnutls_retr_st/gnutls_retr2_st/' \
    -e 's/type = type/cert_&/' \
    -i src/ne_gnutls.c
./configure --prefix=/usr --enable-shared --with-ssl --disable-static
make
# Test (some known to fail):
#make -k check
#
as_root make install
cd ..
as_root rm -rf neon-0.30.1
#
# Add to installed list for this computer:
echo "neon-0.30.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################