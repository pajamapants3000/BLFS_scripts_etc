#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for dhcpcd-6.9.2
#
# Dependencies
#**************
# Begin Required
#llvm-3.6.2
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
grep dhcpcd-6.9.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://roy.marples.name/downloads/dhcpcd/dhcpcd-6.9.2.tar.xz
# FTP/alt Download:
#wget ftp://roy.marples.name/pub/dhcpcd/dhcpcd-6.9.2.tar.xz
#
# md5sum:
echo "2332a96783a2e6c38a0cdf382491055f dhcpcd-6.9.2.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf dhcpcd-6.9.2.tar.xz
cd dhcpcd-6.9.2
./configure --libexecdir=/lib/dhcpcd \
            --dbdir=/var/tmp
make
#
as_root make install
cd ..
as_root rm -rf dhcpcd-6.9.2
#
# Add to installed list for this computer:
echo "dhcpcd-6.9.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-service-dhcpcd
cd ..
#
###################################################
#
# Configuration
#***************
#
source blfs_profile
#
for DEV in ${IFACE[@]}; do
as_root mv -v /etc/sysconfig/ifconfig.$DEV /etc/sysconfig/ifconfig.$DEV".bak"
as_root tee /etc/sysconfig/ifconfig.$DEV << "EOF"
ONBOOT="yes"
IFACE=$DEV
SERVICE="dhcpcd"
DHCP_START="-b -q"
DHCP_STOP="-k"
EOF
done
#
as_root tee /etc/resolv.conf.head << "EOF"
# OpenDNS servers
nameserver 208.67.222.222
nameserver 208.67.220.220
EOF
#
###################################################
