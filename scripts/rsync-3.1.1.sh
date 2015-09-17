#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for rsync-3.1.1
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#popt-1.16
# End Recommended
# Begin Optional
#doxygen-1.8.10
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep rsync-3.1.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://www.samba.org/ftp/rsync/src/rsync-3.1.1.tar.gz
# md5sum:
echo "43bd6676f0b404326eee2d63be3cdcfe rsync-3.1.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf rsync-3.1.1.tar.gz
cd rsync-3.1.1
#
if ! (cat /etc/group | grep rsyncd > /dev/null); then
    pathappend /usr/sbin
    groupadd -g 48 rsyncd
    useradd -c "rsyncd_Daemon" -d /home/rsync -g rsyncd \
        -s /bin/false -u 48 rsyncd
    pathremove /usr/sbin
fi
#
./configure --prefix=/usr --without-included-zlib
make
# with doxygen
#doxygen
#
# Test:
make check
#
as_root make install
# with doxygen
#as_root install -v -m755 -d          /usr/share/doc/rsync-3.1.1/api
#as_root install -v -m644 dox/html/*  /usr/share/doc/rsync-3.1.1/api
#
cd ..
as_root rm -rf rsync-3.1.1
#
# Add to installed list for this computer:
echo "rsync-3.1.1" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
######################################################################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-rsyncd
cd ..
#
###################################################
#
# Configuration
#***************
#
as_root cp -v files/rsyncd.conf /etc/
as_root chown -v root:root /etc/rsyncd.conf
as_root chmod -v 755 /etc/rsyncd.conf
#
###################################################
