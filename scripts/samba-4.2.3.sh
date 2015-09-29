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
#python-2.7.10
# End Required
# Begin Recommended
#libxslt-1.1.28
#openldap-2.4.42
# End Recommended
# Begin Optional
#avahi-0.6.31
#cups-2.0.4
#gnutls-3.4.4.1
#libarchive-3.1.2
#libcap-2.24
#libgpg_error-1.20
#linux_pam-1.2.1
#krb5-1.13.2
#popt-1.16
#valgrind-3.10.1
#xfsprogs-3.2.3
#ctdb
#gamin
#heimdal
#libaio
#libunwind
#ldb
#openafs
#tevent
#tdb
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep samba-4.2.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://download.samba.org/pub/samba/stable/samba-4.2.3.tar.gz
# md5sum:
echo "aeaa6ccee87727b7d01df7b6d0864c74 samba-4.2.3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf samba-4.2.3.tar.gz
cd samba-4.2.3
./configure                             \
    --prefix=/usr                       \
    --sysconfdir=/etc                   \
    --localstatedir=/var                \
    --with-piddir=/run/samba            \
    --with-pammodulesdir=/lib/security  \
    --without-systemd                   \
    --enable-fhs   
make
# Test (this is a whole THING, so I'm commenting out for now):
#make check
#
as_root make install
as_root mv -v /usr/lib/libnss_win{s,bind}.so*   /lib
as_root ln -v -sf ../../lib/libnss_winbind.so.2 /usr/lib/libnss_winbind.so
as_root ln -v -sf ../../lib/libnss_wins.so.2    /usr/lib/libnss_wins.so
as_root install -v -m644    examples/smb.conf.default /etc/samba
as_root mkdir -pv /etc/openldap/schema
as_root install -v -m644    examples/LDAP/README              \
                    /etc/openldap/schema/README.LDAP
as_root install -v -m644    examples/LDAP/samba*              \
                    /etc/openldap/schema
as_root install -v -m755    examples/LDAP/{get*,ol*} \
                    /etc/openldap/schema
as_root install -v -m755 -d /usr/share/doc/samba-4.2.3
as_root install -v -m644    lib/ntdb/doc/design.pdf \
                    /usr/share/doc/samba-4.2.3
cd ..
as_root rm -rf samba-4.2.3
#
# Create symlink if cups is installed
grep cups /list-$CHRISTENED"-"$SURNAME > /dev/null &&
as_root ln -v -sf /usr/bin/smbspool /usr/lib/cups/backend/smb ||
( exit 0 )
# Add to installed list for this computer:
echo "samba-4.2.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-samba
as_root make install-winbindd
cd ..
#
###################################################
#
# Configuration
#***************
if ! (cat /etc/group | grep nogroup > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -g 99 nogroup
    as_root useradd -c "Unprivileged_Nobody" -d /dev/null -g nogroup \
            -s /bin/false -u 99 nobody
    pathremove /usr/sbin
fi
#
as_root cp -v files/smb.conf /etc/samba/smb.conf
as_root chown root:root /etc/samba/smb.conf
as_root chmod 644 /etc/samba/smb.conf
# Alternatively, just copy /etc/samba/smb.conf.default /etc/samba/smb.conf.default
#+and sed it to desired changes, or copy and modify to new files/smb.conf
#
# Also, see
# http://www.linuxfromscratch.org/blfs/view/svn/basicnet/samba.html
# http://www.samba.org/samba/docs/man/Samba-HOWTO-Collection/
# http://www.samba.org/samba/docs/man/Samba-Guide/
###################################################
