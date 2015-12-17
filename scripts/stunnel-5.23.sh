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
#openssl-1.0.2d
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#tcpwrappers
#tor
# End Optional
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep stunnel-5.23 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://www.stunnel.org/downloads/stunnel-5.23.tar.gz
# FTP/alt Download:
#wget ftp://ftp.stunnel.org/stunnel/archive/5.x/stunnel-5.23.tar.gz
#
# md5sum:
echo "55470899902f706e2cd39a614524ca1a stunnel-5.23.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
if ! (cat /etc/group | grep stunnel > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -g 51 stunnel
    as_root useradd -c "stunnel_Daemon" -d /var/lib/stunnel \
            -g stunnel -s /bin/false -u 51 stunnel
    pathremove /usr/sbin
fi

tar -xvf stunnel-5.23.tar.gz
cd stunnel-5.23
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-systemd
make
#
as_root make docdir=/usr/share/doc/stunnel-5.23 install
# Respond to prompt for server name
echo
#
as_root make cert
cd ..
as_root rm -rf stunnel-5.23
#
# Add to installed list for this computer:
echo "stunnel-5.23" >> /list-$CHRISTENED"-"$SURNAME
#
# BLFS-bootscript
cd blfs-bootscripts-20150823
as_root make install-stunnel
cd ..
###################################################
#
# Configuration
#***************
as_root install -v -m750 -o stunnel -g stunnel -d /var/lib/stunnel/run
as_root chown stunnel:stunnel /var/lib/stunnel
as_root cp -v files/etc/stunnel/stunnel.conf /etc/stunnel/
as_root chmod -v 644 /etc/stunnel/stunnel.conf
#
###################################################
