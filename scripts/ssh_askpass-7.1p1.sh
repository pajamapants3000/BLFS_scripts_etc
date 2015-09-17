#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for ssh_askpass-7.1p1
#
# Dependencies
#**************
# Begin Required
#gtk+-2.24.28
#sudo-1.8.14p3
#Xorg Libraries
#X Window System
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep ssh_askpass-7.1p1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
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
tar -xvf openssh-7.1p1.tar.gz
cd openssh-7.1p1
cd contrib
make gnome-ssh-askpass2
# Test:
make check
#
as_root install -v -d -m755                  /usr/libexec/openssh/contrib
as_root install -v -m755  gnome-ssh-askpass2 /usr/libexec/openssh/contrib
as_root ln -sv -f contrib/gnome-ssh-askpass2 /usr/libexec/openssh/ssh-askpass
#
askpass tee -a /etc/sudo.conf << "EOF"
# Path to askpass helper program
Path askpass /usr/libexec/openssh/ssh-askpass
EOF
askpass chmod -v 0644 /etc/sudo.conf
cd ..
as_root rm -rf openssh-7.1p1
#
# Add to installed list for this computer:
echo "ssh_askpass-7.1p1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################