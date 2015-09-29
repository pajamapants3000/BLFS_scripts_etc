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
#openssl-1.0.2
# End Required
# Begin Recommended
#db-6.1.19
# End Recommended
# Begin Optional
#linux_pam-1.1.8
#krb5-1.13.1
#mariadb-10.0.16
#mysql
#openjdk-1.8.0.31
#openldap-2.4.40
#postgresql-9.4.1
#sqlite-3.8.8.2
#krb4
#dmalloc
# End Optional
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
grep cyrus_sasl-2.1.26 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.cyrusimap.org/cyrus-sasl/cyrus-sasl-2.1.26.tar.gz
# md5sum:
echo "a7f4e5e559a0e37b3ffc438c9456e425 cyrus-sasl-2.1.26.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch download:
wget http://www.linuxfromscratch.org/patches/blfs/7.7/cyrus-sasl-2.1.26-fixes-3.patch
#
tar -xvf cyrus-sasl-2.1.26.tar.gz
cd cyrus-sasl-2.1.26
patch -Np1 -i ../cyrus-sasl-2.1.26-fixes-3.patch
autoreconf -fi
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --enable-auth-sasldb \
            --with-dbpath=/var/lib/sasl/sasldb2 \
            --with-saslauthd=/var/run/saslauthd
make -j1
#
as_root make install
as_root install -v -dm755 /usr/share/doc/cyrus-sasl-2.1.26
as_root install -v -m644  doc/{*.{html,txt,fig},ONEWS,TODO} \
    saslauthd/LDAP_SASLAUTHD /usr/share/doc/cyrus-sasl-2.1.26
as_root install -v -dm700 /var/lib/sasl
cd ..
as_root rm -rf cyrus-sasl-2.1.26
#
# Add to installed list for this computer:
echo "cyrus_sasl-2.1.26" >> /list-$CHRISTENED"-"$SURNAME
#
# Configuration
#***************
# Init Script:
cd blfs-bootscripts-20150823
as_root make install-saslauthd
cd ..
#
source blfs_profile
as_root sed -i s@"^\(START=\).*$"@"\1\"yes\""@ /etc/sysconfig/saslauthd
as_root sed -i s@"^\(AUTHMECH=\)\""@"\1\""$AUTHMECH@ /etc/sysconfig/saslauthd
###################################################
