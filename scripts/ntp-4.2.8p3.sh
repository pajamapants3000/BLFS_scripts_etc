#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for ntp-4.2.8p3
#
# Dependencies
#**************
# Begin Required
#wget-1.16.3
#which-2.21
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#libcap-2.24
#libevent-2.0.22
#openssl-1.0.2d
#libedit
#libopts
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep ntp-4.2.8p3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download - had to skip cert check:
wget --no-check-certificate https://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/ntp-4.2.8p3.tar.gz
# md5sum:
echo "b98b0cbb72f6df04608e1dd5f313808b ntp-4.2.8p3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
if ! (cat /etc/group | grep ntp > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -g 87 ntp
    as_root useradd -c "Network_Time_Protocol" -d /var/lib/ntp -u 87 \
            -g ntp -s /bin/false ntp
    pathremove /usr/sbin
fi
#
tar -xvf ntp-4.2.8p3.tar.gz
cd ntp-4.2.8p3
./configure --prefix=/usr         \
            --bindir=/usr/sbin    \
            --sysconfdir=/etc     \
            --enable-linuxcaps    \
            --with-lineeditlibs=readline \
            --docdir=/usr/share/doc/ntp-4.2.8p3
make
# Test:
make check
#
as_root make install
as_root install -v -o ntp -g ntp -d /var/lib/ntp
cd ..
as_root rm -rf ntp-4.2.8p3
#
# Add to installed list for this computer:
echo "ntp-4.2.8p3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-ntpd
cd ..
#
# If you prefer to run ntpd periodically, add the following command to root's crontab:
#ntpd -q
###################################################
#
# Configuration
#***************
#
as_root tee /etc/ntp.conf << "EOF"
# Asia
server 0.asia.pool.ntp.org

# Australia
server 0.oceania.pool.ntp.org

# Europe
server 0.europe.pool.ntp.org

# North America
server 0.north-america.pool.ntp.org

# South America
server 2.south-america.pool.ntp.org

driftfile /var/lib/ntp/ntp.drift
pidfile   /var/run/ntpd.pid

leapfile  /etc/ntp.leapseconds

# Security session
restrict    default limited kod nomodify notrap nopeer noquery
restrict -6 default limited kod nomodify notrap nopeer noquery

restrict 127.0.0.1
restrict ::1
EOF
#
# Set hwclock to system time at shutdown/reboot
as_root ln -v -sf ../init.d/setclock /etc/rc.d/rc0.d/K46setclock
as_root ln -v -sf ../init.d/setclock /etc/rc.d/rc6.d/K46setclock
###################################################
