#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for openldap-2.4.42-client
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#cyrus_sasl-2.1.26
#openssl-1.0.2d 
# End Recommended
# Begin Optional
#icu-55.1
#pth-2.0.7
#unixodbc-2.3.2
#mariadb-10.0.20
#postgresql-9.4.4
#mysql
#openslp
#db-6.1.26
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "openldap-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.42.tgz
# md5sum:
echo "47c8e2f283647a6105b8b0325257e922 openldap-2.4.42.tgz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/openldap-2.4.42-consolidated-1.patch
#
tar -xvf openldap-2.4.42.tgz
cd openldap-2.4.42
patch -Np1 -i ../openldap-2.4.42-consolidated-1.patch
autoconf
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static  \
            --enable-dynamic  \
            --disable-debug   \
            --disable-slapd
make depend
make
#
as_root make install
cd ..
as_root rm -rf openldap-2.4.42
#
# Add to installed list for this computer:
echo "openldap-2.4.42-client" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
