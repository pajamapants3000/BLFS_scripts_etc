#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for curl-7.44.0
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#certdata
#openssl-1.0.2d
#gnutls-3.4.2 
# End Recommended
# Begin Optional
#libidn-1.31
#krb5-1.13.2
#openldap-2.4.42
#samba-4.2.2
#c_ares
#libmetalink
#libssh2
#spnego
#stunnel-5.23
#valgrind-3.10.1 
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep curl-7.44.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://curl.haxx.se/download/curl-7.44.0.tar.lzma
# md5sum:
echo "2f924c80bb7124dff1b39f54ffda3781 curl-7.44.0.tar.lzma" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf curl-7.44.0.tar.lzma
cd curl-7.44.0
./configure --prefix=/usr              \
            --disable-static           \
            --enable-threaded-resolver
make
# Test:
make test
#
as_root make install
find docs \( -name Makefile\* -o -name \*.1 -o -name \*.3 \) -exec as_root rm {} \;
as_root install -v -d -m755 /usr/share/doc/curl-7.44.0
as_root cp -v -R docs/*     /usr/share/doc/curl-7.44.0
cd ..
as_root rm -rf curl-7.44.0
#
# Add to installed list for this computer:
echo "curl-7.44.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
