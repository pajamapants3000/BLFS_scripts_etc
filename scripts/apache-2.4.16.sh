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
#apr_util-1.5.4
#pcre-8.37
# End Required
# Begin Recommended
#openssl-1.0.2d
# End Recommended
# Begin Optional
#db-6.1.26
#doxygen-1.8.10
#libxml2-2.9.2
#lynx-2.8.8rel.2
#links-2.10
#elinks
#openldap-2.4.42
#apr_util-1.5.4
#rsync-3.1.1
#distcache
#lua-5.3.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep apache-2.4.16 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://archive.apache.org/dist/httpd/httpd-2.4.16.tar.bz2
# FTP/alt Download:
#wget XXX
#
# md5sum:
echo "2b19cd338fd526dd5a63c57b1e9bfee2 httpd-2.4.16.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/httpd-2.4.16-blfs_layout-1.patch
#
if ! (cat /etc/group | grep apache > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -g 25 apache
    as_root useradd -c "Apache_Server" -d /srv/www -g apache \
        -s /bin/false -u 25 apache
    pathremove /usr/sbin
fi
#
tar -xvf httpd-2.4.16.tar.bz2
cd httpd-2.4.16
patch -Np1 -i ../httpd-2.4.16-blfs_layout-1.patch
sed '/dir.*CFG_PREFIX/s@^@#@'     -i support/apxs.in
./configure --enable-authnz-fcgi                            \
            --enable-layout=BLFS                            \
            --enable-mods-shared="all cgi"                  \
            --enable-mpms-shared=all                        \
            --enable-suexec=shared                          \
            --with-apr=/usr/bin/apr-1-config                \
            --with-apr-util=/usr/bin/apu-1-config           \
            --with-suexec-bin=/usr/lib/httpd/suexec         \
            --with-suexec-caller=apache                     \
            --with-suexec-docroot=/srv/www                  \
            --with-suexec-logfile=/var/log/httpd/suexec.log \
            --with-suexec-uidmin=100                        \
            --with-suexec-userdir=public_html
make
#
as_root make install
as_root mv -v /usr/sbin/suexec /usr/lib/httpd/suexec
as_root chgrp apache           /usr/lib/httpd/suexec
as_root chmod 4754             /usr/lib/httpd/suexec
as_root chown -v -R apache:apache /srv/www
cd ..
as_root rm -rf httpd-2.4.16
#
# Add to installed list for this computer:
echo "apache-2.4.16" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-httpd
cd ..
#
###################################################
