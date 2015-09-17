#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for openldap-2.4.42
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
wget ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-2.4.42.tgz
# md5sum:
echo "47c8e2f283647a6105b8b0325257e922 openldap-2.4.42.tgz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/openldap-2.4.42-consolidated-1.patch
#
if ! (cat /etc/group | grep ldap > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -g 83 ldap
    as_root useradd -c "OpenLDAP_Daemon_Owner" -d /var/lib/openldap -u 83 \
            -g ldap -s /bin/false ldap
    pathremove /usr/sbin
fi
#
tar -xvf openldap-2.4.42.tgz
cd openldap-2.4.42
patch -Np1 -i ../openldap-2.4.42-consolidated-1.patch
autoconf
./configure --prefix=/usr         \
            --sysconfdir=/etc     \
            --localstatedir=/var  \
            --libexecdir=/usr/lib \
            --disable-static      \
            --disable-debug       \
            --with-tls=openssl    \
            --with-cyrus-sasl     \
            --enable-dynamic      \
            --enable-crypt        \
            --enable-spasswd      \
            --enable-slapd        \
            --enable-modules      \
            --enable-backends=mod \
            --disable-ndb         \
            --disable-sql         \
            --disable-shell       \
            --disable-bdb         \
            --disable-hdb         \
            --enable-overlays=mod
make depend
make
# Test (about 65 min, processor independent and touchy!):
#make test
#
as_root make install
as_root install -v -dm700 -o ldap -g ldap /var/lib/openldap
as_root install -v -dm700 -o ldap -g ldap /etc/openldap/slapd.d
as_root chmod -v 640       /etc/openldap/slapd.{conf,ldif}
as_root chown -v root:ldap /etc/openldap/slapd.{conf,ldif}
as_root install -v -dm755              /usr/share/doc/openldap-2.4.42
as_root cp -vfr doc/{drafts,rfc,guide} /usr/share/doc/openldap-2.4.42
cd ..
as_root rm -rf openldap-2.4.42
#
# Add to installed list for this computer:
echo "openldap-2.4.42" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Init Script
#*************
#cd blfs-bootscripts-20150823
#as_root make install-slapd
#cd ..
#
###################################################
#
# Testing the Configuration
#**************************
#
# Start the server
#/etc/rc.d/init.d/slapd start
#
# Verify access to the server
#ldapsearch -x -b '' -s base '(objectclass=*)' namingContexts
#
# We expect to see:
# extended LDIF
#
# LDAPv3
# base <> with scope baseObject
# filter: (objectclass=*)
# requesting: namingContexts
#
#
##
#dn:
#namingContexts: dc=my-domain,dc=com
#
# search result
#search: 2
#result: 0 Success
#
# numResponses: 2
# numEntries: 1
#
###################################################
