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
#nettle-3.1.1
# End Required
# Begin Recommended
#certdata
#libtasn1-4.5
#p11_kit-0.23.1
# End Recommended
# Begin Optional
#doxygen-1.8.10
#gtk_doc-1.24
#guile-2.0.11
#libidn-1.31
#texlive-20150521
#unbound-1.5.4
#valgrind-3.10.1
#autogen
#trousers
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gnutls-3.4.4.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.gnutls.org/gcrypt/gnutls/v3.4/gnutls-3.4.4.1.tar.xz
# md5sum:
echo "474efaba6fd6c6c6c0ebac2a3f431946 gnutls-3.4.4.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gnutls-3.4.4.1.tar.xz
cd gnutls-3.4.4.1
./configure --prefix=/usr \
            --with-default-trust-store-file=/etc/ssl/ca-bundle.crt
make
# Test:
make check
#
as_root make install
as_root make -C doc/reference install-data-local
cd ..
as_root rm -rf gnutls-3.4.4.1
#
# Add to installed list for this computer:
echo "gnutls-3.4.4.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################