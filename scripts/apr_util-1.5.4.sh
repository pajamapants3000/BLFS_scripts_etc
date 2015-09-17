#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for apr_util-1.5.4
#
# Dependencies
#**************
# Begin Required
#apr-1.5.2
# End Required
# Begin Recommended
#openssl-1.0.2d
# End Recommended
# Begin Optional
#db-6.1.26
#freetds
#mariadb-10.0.20
#mysql
#openldap-2.4.42
#postgresql-9.4.4
#sqlite-3.8.11.1
#unixodbc-2.3.2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep apr_util-1.5.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.apache.org/dist/apr/apr-util-1.5.4.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.mirrorservice.org/sites/ftp.apache.org/apr/apr-util-1.5.4.tar.bz2
#
# md5sum:
echo "2202b18f269ad606d70e1864857ed93c apr-util-1.5.4.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf apr-util-1.5.4.tar.bz2
cd apr-util-1.5.4
./configure --prefix=/usr       \
            --with-apr=/usr     \
            --with-gdbm=/usr    \
            --with-openssl=/usr \
            --with-crypto
make
# Test:
make test
#
as_root make install
cd ..
as_root rm -rf apr-util-1.5.4
#
# Add to installed list for this computer:
echo "apr_util-1.5.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################