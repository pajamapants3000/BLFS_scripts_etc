#!/bin/bash -ev
# Beyond Linux From Scratch 7.7
# Installation script for xdg_utils-1.1.0-rc3
#
# Dependencies
#**************
# Begin Required
#xmlto-0.0.26
#lynx-2.8.8rel.2
#w3m-0.5.3
#links-2.9
#fop-1.1
#Xorg Applications
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#d_bus-1.8.16
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xdg_utils-1.1.0-rc3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://people.freedesktop.org/~rdieter/xdg-utils/xdg-utils-1.1.0-rc3.tar.gz
# md5sum:
echo "617ef5f9872ab5b148ad4717bc9012f5 xdg-utils-1.1.0-rc3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xdg-utils-1.1.0-rc3.tar.gz
cd xdg-utils-1.1.0-rc3
./configure --prefix=/usr --mandir=/usr/share/man
make
# Test (requires: X session, MTA, browser...):
#make -k test
#
as_root make install
cd ..
as_root rm -rf xdg-utils-1.1.0-rc3
#
# Add to installed list for this computer:
echo "xdg_utils-1.1.0-rc3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################