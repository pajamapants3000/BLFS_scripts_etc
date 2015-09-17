#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for Tripwire-2.4.2.2-SMTP
# Time: 1.3 SBU (includes interactive time during install)
#
# Dependencies
#**************
# Begin Required
#openssl-1.0.2
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
#
# Check for previous installation:
PROCEED="yes"
grep tripwire-2.4.2.2-SMTP /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/tripwire/tripwire-2.4.2.2-src.tar.bz2
# md5sum:
echo "2462ea16fb0b5ae810471011ad2f2dd6 tripwire-2.4.2.2-src.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf tripwire-2.4.2.2-src.tar.bz2
cd tripwire-2.4.2.2-src
sed -i -e 's@TWDB="${prefix}@TWDB="/var@' install/install.cfg
sed -i -e 's/!Equal/!this->Equal/' src/cryptlib/algebra.h
sed -i -e '/stdtwadmin.h/i#include <unistd.h>' src/twadmin/twadmincl.cpp
sed -i -e '/TWMAN/ s|${prefix}|/usr/share|' \
       -e '/TWDOCS/s|${prefix}|/usr/share|' install/install.cfg
sed -i -e 's/eArchiveOpen e\([^)]*)\)/throw ( eArchiveOpen\1 )/' \
       -e '/throw e;/d' src/core/archive.cpp
./configure --prefix=/usr --sysconfdir=/etc/tripwire
make
#
# Modify for lack of MTA
sed -i -e 's@\(TWMAILMETHOD=SENDMAIL\)@#\1@' install/install.cfg
sed -i -e 's@#\(TWMAILMETHOD=SMTP\)@\1@' install/install.cfg
sed -i -e 's@#\(TWSMTPHOST="mail.domain.com"\)@\1@' install/install.cfg
sed -i -e 's@#\(TWSMTPPORT=25\)@\1@' install/install.cfg
#
# Preset password for automation purposes; should change after!
sed -i -e 's@install/install.sh@& -n -s sesle -l lesle@' Makefile
#
as_root make install
as_root cp -v policy/*.txt /usr/share/doc/tripwire-2.4.2.2
#
cd ..
as_root rm -rf tripwire-2.4.2.2-src
#
# Add to installed list for this computer:
echo "tripwire-2.4.2.2-SMTP" >> /list-$CHRISTENED"-"$SURNAME
#
# Command Explanations
# sed -i -e 's@TWDB="${prefix}@TWDB="/var@' install/install.cfg: This command tells the package to install the program database and reports in /var/lib/tripwire.
# sed ... src/cryptlib/algebra.h: Fix a compilation issue with gcc-4.7.
# sed ... src/twadmin/twadmincl.cpp: Fix a compilation issue with gcc-4.7.
# sed ... install/install.cfg: Fix the location of the man and doc directories.
# sed ... src/core/archive.cpp: Fix compilation with gcc-4.9.
# make install: This command creates the Tripwire security keys as well as installing the binaries. There are two keys: a site key and a local key which are stored in /etc/tripwire/.
# cp -v policy/*.txt /usr/doc/tripwire: This command installs the tripwire sample policy files with the other tripwire documentation.
#
# Installed:
# siggen, tripwire, twadmin, and twprint
#
###################################################
#
# Config Files
# /etc/tripwire/*
#
# CONFIGURATION:
#
pathappend /usr/sbin
as_root twadmin --create-polfile --site-keyfile /etc/tripwire/site.key \
    /etc/tripwire/twpol.txt
as_root tripwire --init
pathremove /usr/sbin
###################################################