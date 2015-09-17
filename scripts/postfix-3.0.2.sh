#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for Postfix-3.0.2
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#db-6.1.26
#cyrus_sasl-2.1.26
#openssl-1.0.2d
# End Recommended
# Begin Optional
#icu-55.1
#mariadb-10.0.20
#mysql
#openldap-2.4.42
#pcre-8.37
#postgresql-9.4.4
#sqlite-3.8.11.1
#cdb
#tinycdb
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep postfix-3.0.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.porcupine.org/mirrors/postfix-release/official/postfix-3.0.2.tar.gz
# md5sum:
echo "d1dc2c23011c222129db3d91aa4f312a postfix-3.0.2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf postfix-3.0.2.tar.gz
cd postfix-3.0.2
#
if ! (cat /etc/group | grep postfix > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -g 32 postfix
    as_root groupadd -g 33 postdrop
    as_root useradd -c "Postfix_Daemon_User" -d /var/spool/postfix -g postfix \
            -s /bin/false -u 32 postfix
    pathremove /usr/sbin
fi
as_root chown -v postfix:postfix /var/mail
#
sed -i 's/.\x08//g' README_FILES/*
# If Linux kernel is 4.X
#sed -i 's/Linux.3\*/Linux.[34]\*/' makedefs

# Choose configuration arguments:
# Cyrus-SASL
# CCARGS='-DUSE_SASL_AUTH -DUSE_CYRUS_SASL -I/usr/include/sasl'
# AUXLIBS='-lsasl2'
# OpenLDAP
# CCARGS='-DHAS_LDAP'
# AUXLIBS='-lldap -llber'
# Sqlite
# CCARGS='-DHAS_SQLITE'
# AUXLIBS='-lsqlite3 -lpthread'
# MySQL
# CCARGS='-DHAS_MYSQL -I/usr/include/mysql'
# AUXLIBS='-lmysqlclient -lz -lm'
# PostgreSQL
# CCARGS='-DHAS_PGSQL -I/usr/include/postgresql'
# AUXLIBS='-lpq -lz -lm'
# CDB/TinyCDB
# CCARGS='-DHAS_CDB'
# AUXLIBS='</path/to/CDB>/libcdb.a'
# To use OpenSSL with Postfix, use the following arguments:
# CCARGS='-DUSE_TLS -I/usr/include/openssl/'
# AUXLIBS='-lssl -lcrypto'
#
# For Cyrus SASL and OpenSSL:
#make CCARGS="-DUSE_TLS -I/usr/include/openssl/                     \
#             -DUSE_SASL_AUTH -DUSE_CYRUS_SASL -I/usr/include/sasl" \
#     AUXLIBS="-lssl -lcrypto -lsasl2"                              \
#     makefiles
# For Cyrus SASL, OpenSSL, SQLite:
make CCARGS="-DUSE_TLS -I/usr/include/openssl                     \
             -DUSE_SASL_AUTH -DUSE_CYRUS_SASL -I/usr/include/sasl \
             -DHAS_SQLITE"                                        \
    AUXLIBS="-lssl -lcrypto -lsasl2                               \
             -lsqlite3 -lpthread"                                 \
    makefiles
make
#
as_root sh postfix-install -non-interactive \
   daemon_directory=/usr/lib/postfix \
   manpage_directory=/usr/share/man \
   html_directory=/usr/share/doc/postfix-3.0.2/html \
   readme_directory=/usr/share/doc/postfix-3.0.2/readme
#
cd ..
as_root rm -rf postfix-3.0.2
#
# Add to installed list for this computer:
echo "postfix-3.0.2" >> /list-$CHRISTENED"-"$SURNAME
#
# Command Explanations
# make makefiles: This command rebuilds the makefiles throughout the source tree to use the options contained in the CCARGS and AUXLIBS variables.
# sh postfix-install -non-interactive: This keeps the install script from asking any questions, thereby accepting default destination directories in all but the few cases. If the html_directory and readme_directory options are not set then the documentation will not be installed.
#
# Installed:
# mailq, newaliases, postalias, postcat, postconf, postdrop, postfix, postkick,
# postlock, postlog, postmap, postmulti, postqueue, postsuper, and sendmail
#
# Boot Script
cd blfs-bootscripts-20150823
as_root make install-postfix
cd ..
#
###################################################
#
# Config Files
# /etc/aliases, /etc/postfix/main.cf, and /etc/postfix/master.cf
#
# Replace tommy with username to receive root's forwarded email
as_root tee -a /etc/aliases << "EOF"
# Begin /etc/aliases

MAILER-DAEMON:    postmaster
postmaster:       root

root:             tommy
# End /etc/aliases
EOF
#
# Check file for duplicates
#
# Note
# The /etc/postfix/main.cf and /etc/postfix/master.cf files must be
#   personalized for your system. The main.cf file needs your fully
#   qualified hostname. You will find that main.cf is self documenting, so
#   load it into your editor to make the changes you need for your situation.
#
# Note
# Postfix can also be set up to run in a chroot jail. See the file in the
#   source examples/chroot-setup/LINUX2 for details.
#
# If you have an existing configuration, add necessary definitions to existing files:
#as_root /usr/sbin/postfix upgrade-configuration
#
# Check that config and permissions work properly, check and start server:
#as_root /usr/sbin/postfix check
#as_root /usr/sbin/postfix start
#
# RUN THESE LAST TWO COMMANDS MANUALLY AFTER INSTALLATION
#
# Update args and reinstall after any DB, OpenLDAP, or PCRE
#
#####################################################################
