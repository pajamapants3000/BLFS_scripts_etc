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
##libressl_portable
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#linux_pam-1.2.1
#X Window System
#krb5-1.13.2
#libedit
#opensc
#libsectok
#openjdk-1.8.0.45
#net_tools_cvs-20101030
#sysstat-11.1.5
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep openssh-7.1p1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-7.1p1.tar.gz
# FTP/alt Download:
#wget ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-7.1p1.tar.gz
#
# md5sum:
echo "8709736bc8a8c253bc4eeb4829888ca5 openssh-7.1p1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
as_root install  -v -m700 -d /var/lib/sshd
as_root chown    -v root:sys /var/lib/sshd
if ! (cat /etc/group | grep sshd > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -g 50 sshd
    as_root useradd -c 'sshd_PrivSep' -d /var/lib/sshd -g sshd -s /bin/false -u 50 sshd
    pathremove /usr/sbin
fi
#
tar -xvf openssh-7.1p1.tar.gz
cd openssh-7.1p1
./configure --prefix=/usr                     \
            --sysconfdir=/etc/ssh             \
            --with-md5-passwords              \
            --with-privsep-path=/var/lib/sshd
make
# Test (requires installed copy of scp from this package! Copy scp to /usr/bin,
#+backing up any existing copy first):
#make tests
#
as_root make install
as_root install -v -m755 contrib/ssh-copy-id /usr/bin
as_root install -v -m644 contrib/ssh-copy-id.1 /usr/share/man/man1
as_root install -v -m755 -d /usr/share/doc/openssh-7.1p1
as_root install -v -m644 INSTALL LICENCE OVERVIEW README* /usr/share/doc/openssh-7.1p1
cd ..
as_root rm -rf openssh-7.1p1
#
# Add to installed list for this computer:
echo "openssh-7.1p1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-sshd
cd ..
#
###################################################
#
# Configuration
#***************
#
# Disable root remote login
#as_root echo "PermitRootLogin no" >> /etc/ssh/sshd_config
# Enable passwordless login from REMOTE_USERNAME@REMOTE_HOSTNAME
#source ${HOME}/.blfs_profile
#as_root ssh-keygen
#as_root ssh-copy-id -i ~/.ssh/id_rsa.pub $REMOTE_USERNAME@$REMOTE_HOSTNAME
# To disable password logins (if you've enabled passwordless logins)
#as_root echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
#as_root echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config
# Alternatively, if using passwords and have PAM
#as_root sed 's@d/login@d/sshd@g' /etc/pam.d/login > /etc/pam.d/sshd
#as_root chmod 644 /etc/pam.d/sshd
#as_root echo "UsePAM yes" >> /etc/ssh/sshd_config
###################################################
