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
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#linux_pam-1.2.1
#krb5-1.13.2
#openldap-2.4.42
#mta
#afs
#fwtk
#opie
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep sudo-1.8.14p3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.sudo.ws/dist/sudo-1.8.14p3.tar.gz
# FTP/alt Download:
#wget ftp://ftp.sudo.ws/pub/sudo/sudo-1.8.14p3.tar.gz
#
# md5sum:
echo "93dbd1e47c136179ff1b01494c1c0e75 sudo-1.8.14p3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf sudo-1.8.14p3.tar.gz
cd sudo-1.8.14p3
./configure --prefix=/usr              \
            --libexecdir=/usr/lib      \
            --with-secure-path         \
            --with-all-insults         \
            --with-env-editor          \
            --docdir=/usr/share/doc/sudo-1.8.14p3 \
            --with-passprompt="[sudo] password for %p"
make
# Test:
env LC_ALL=C make check 2>&1 | tee ../make-check.log
# Check results
#grep failed ../make-check.log
#
su -c "make install"
su -c "ln -sfv libsudo_util.so.0.0.0 /usr/lib/sudo/libsudo_util.so.0"
#
grep linux_pam /list-$CHRISTENED"-"$SURNAME > /dev/null && \
su -c "tee /etc/pam.d/sudo << EOF
# Begin /etc/pam.d/sudo

# include the default auth settings
auth      include     system-auth

# include the default account settings
account   include     system-account

# Set default environment variables for the service user
session   required    pam_env.so

# include system session defaults
session   include     system-session

# End /etc/pam.d/sudo
EOF"
grep linux_pam /list-$CHRISTENED"-"$SURNAME > /dev/null && \
su -c "chmod 644 /etc/pam.d/sudo"
cd ..
su -c "rm -rf sudo-1.8.14p3"
#
# Add to installed list for this computer:
echo "sudo-1.8.14p3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
