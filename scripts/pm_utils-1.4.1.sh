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
#xmlto-0.0.26
#hdparm-9.45
#wireless_tools-29
#ethtool
#vbetool
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep pm_utils-1.4.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://pm-utils.freedesktop.org/releases/pm-utils-1.4.1.tar.gz
# md5sum:
echo "1742a556089c36c3a89eb1b957da5a60 pm-utils-1.4.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pm-utils-1.4.1.tar.gz
cd pm-utils-1.4.1
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/pm-utils-1.4.1
make
#
as_root make install
# Without xmlto installed
as_root install -v -m644 man/*.1 /usr/share/man/man1
as_root install -v -m644 man/*.8 /usr/share/man/man8
as_root ln -sfv pm-action.8 /usr/share/man/man8/pm-suspend.8
as_root ln -sfv pm-action.8 /usr/share/man/man8/pm-hibernate.8
as_root ln -sfv pm-action.8 /usr/share/man/man8/pm-suspend-hybrid.8
#
cd ..
as_root rm -rf pm-utils-1.4.1
#
# Add to installed list for this computer:
echo "pm_utils-1.4.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
