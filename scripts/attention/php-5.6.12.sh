#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for php-5.6.12
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#apache-2.4.16
#libxml2-2.9.2
# End Recommended
# Begin Optional
#libxslt-1.1.28
#pcre-8.37
#aspell-0.60.6.1
#enchant-1.6.0
#pth-2.0.7
#mta
#ossp_mm
#net_snmp
#re2c
#xmlrpc_epi
#dmalloc
#libjpeg_turbo-1.4.1
#tiff-4.0.5
#libpng-1.6.18
#libexif-0.6.21
#freetype-2.6
#x_window_system
#clibpdf
#gd
#t1lib
#fdf_toolkit
#curl-7.44.0
#html_tidy_cvs-20101110
#mnogosearch
#hyperwave
#roxen_webserver
#caudium
#wddx
#openldap-2.4.42
#db-6.1.26
#mariadb-10.0.20
#mysql
#postgresql-9.4.4
#unixodbc-2.3.2
#sqlite-3.8.11.1
#qdbm
#cdb
#mini_sql
#empress
#birdstep
#dbmaker
#adabas
#frontbase
#monetra
#oracle
#sap
#odbc_router.
#openssl-1.0.2d
#cyrus sasl-2.1.26
#krb5-1.13.2
#libmcrypt
#mhash 
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "php-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.php.net/distributions/php-5.6.12.tar.xz
# FTP/alt Download:
#wget ftp://ftp.isu.edu.tw/pub/Unix/Web/PHP/distributions/php-5.6.12.tar.xz
#
# md5sum:
echo "f2cc602602eb2b121779f2c4b8bacaba php-5.6.12.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Prebuilt docs - optional
wget http://www.php.net/download-docs.php
#
tar -xvf php-5.6.12.tar.xz
cd php-5.6.12
./configure --prefix=/usr                \
            --sysconfdir=/etc            \
            --localstatedir=/var         \
            --datadir=/usr/share/php     \
            --mandir=/usr/share/man      \
            --enable-fpm                 \
            --with-fpm-user=apache       \
            --with-fpm-group=apache      \
            --with-config-file-path=/etc \
            --with-zlib                  \
            --enable-bcmath              \
            --with-bz2                   \
            --enable-calendar            \
            --enable-dba=shared          \
            --with-gdbm                  \
            --with-gmp                   \
            --enable-ftp                 \
            --with-gettext               \
            --enable-mbstring            \
            --with-readline      
make
# Test:
yes "n" | make test
#
as_root make install
as_root install -v -m644 php.ini-production /etc/php.ini
as_root mv -v /etc/php-fpm.conf{.default,}
as_root install -v -m755 -d /usr/share/doc/php-5.6.12
as_root install -v -m644    CODING_STANDARDS EXTENSIONS INSTALL NEWS README* UPGRADING* php.gif \
                    /usr/share/doc/php-5.6.12
as_root ln -v -sfn          /usr/lib/php/doc/Archive_Tar/docs/Archive_Tar.txt \
                    /usr/share/doc/php-5.6.12
as_root ln -v -sfn          /usr/lib/php/doc/Structures_Graph/docs \
                    /usr/share/doc/php-5.6.12
# Install the docs
# Single big html file
as_root install -v -m644 ../php_manual_en.html.gz \
    /usr/share/doc/php-5.6.12
as_root gunzip -v /usr/share/doc/php-5.6.12/php_manual_en.html.gz
# Many HTML files
as_root tar -xvf ../php_manual_en.tar.gz \
    -C /usr/share/doc/php-5.6.12 --no-same-owner
cd ..
as_root rm -rf php-5.6.12
#
as_root sed -i 's@php/includes"@&\ninclude_path = ".:/usr/lib/php"@' \
    /etc/php.ini
#
as_root sed -i -e '/proxy_module/s/^#//'      \
       -e '/proxy_fcgi_module/s/^#//' \
       /etc/httpd/httpd.conf
as_root echo \
'ProxyPassMatch ^/(.*\.php)$ fcgi://127.0.0.1:9000/srv/www/$1' >> \
/etc/httpd/httpd.conf

# Add to installed list for this computer:
echo "php-5.6.12" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-php
cd ..
#
###################################################