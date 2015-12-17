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
#libglade-2.6.4
#xorg_applications
# End Required
# Begin Recommended
#glu-9.0.0
# End Recommended
# Begin Optional
#gdm
#gle
#linux_pam-1.2.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "xscreensaver-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.jwz.org/xscreensaver/xscreensaver-5.33.tar.gz
# md5sum:
echo "cd99d65b143cc2c7b010b185aa1413b8 xscreensaver-5.33.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xscreensaver-5.33.tar.gz
cd xscreensaver-5.33
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf xscreensaver-5.33
#
# Add to installed list for this computer:
echo "xscreensaver-5.33" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Configuration (pam)
#
if (cat /list-$CHRISTENED"-"$SURNAME | grep "linux_pam" > /dev/null); then
    install -Dm644 -o root -g root files/etc/pam.d/xscreensaver /etc/pam.d/xscreensaver
fi
#
###################################################
