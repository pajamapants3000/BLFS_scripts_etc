#!/bin/bash -ev
# Beyond Linux From Scratch
# Main run - 09
# Installation script for Iptables-1.4.21
# Time: 0.2 SBU
# Check for previous installation:
PROCEED="yes"
grep iptables-1.4.21 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.netfilter.org/projects/iptables/files/iptables-1.4.21.tar.bz2
# md5sum:
echo "536d048c8e8eeebcd9757d0863ebb0c0 iptables-1.4.21.tar.bz2" | md5sum -c
tar -xvf iptables-1.4.21.tar.bz2
cd iptables-1.4.21
./configure --prefix=/usr                \
            --sbindir=/sbin              \
            --with-xtlibdir=/lib/xtables \
            --enable-libipq
make
as_root make install
as_root ln -sfv ../../sbin/xtables-multi /usr/bin/iptables-xml
for file in ip4tc ip6tc ipq iptc xtables
do
  as_root mv -v /usr/lib/lib${file}.so.* /lib
  as_root ln -sfv ../../lib/$(readlink /usr/lib/lib${file}.so) /usr/lib/lib${file}.so
done
cd ..
as_root rm -rf iptables-1.4.21
cd blfs-bootscripts-20150823
as_root make install-iptables
cd ..
######################
# \/  \/  \/  \/  \/ #
###SET UP FIREWALL!###
# \/  \/  \/  \/  \/ #
######################
as_root tee /etc/rc.d/rc.iptables << "EOF"
#!/bin/sh

# Begin rc.iptables

# Insert connection-tracking modules
# (not needed if built into the kernel)
modprobe nf_conntrack
modprobe xt_LOG

# Enable broadcast echo Protection
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts

# Disable Source Routed Packets
echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route
echo 0 > /proc/sys/net/ipv4/conf/default/accept_source_route

# Enable TCP SYN Cookie Protection
echo 1 > /proc/sys/net/ipv4/tcp_syncookies

# Disable ICMP Redirect Acceptance
echo 0 > /proc/sys/net/ipv4/conf/default/accept_redirects

# Do not send Redirect Messages
echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects
echo 0 > /proc/sys/net/ipv4/conf/default/send_redirects

# Drop Spoofed Packets coming in on an interface, where responses
# would result in the reply going out a different interface.
echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter
echo 1 > /proc/sys/net/ipv4/conf/default/rp_filter

# Log packets with impossible addresses.
echo 1 > /proc/sys/net/ipv4/conf/all/log_martians
echo 1 > /proc/sys/net/ipv4/conf/default/log_martians

# be verbose on dynamic ip-addresses  (not needed in case of static IP)
echo 2 > /proc/sys/net/ipv4/ip_dynaddr

# disable Explicit Congestion Notification
# too many routers are still ignorant
echo 0 > /proc/sys/net/ipv4/tcp_ecn

# Set a known state
iptables -P INPUT   DROP
iptables -P FORWARD DROP
iptables -P OUTPUT  DROP

# These lines are here in case rules are already in place and the
# script is ever rerun on the fly. We want to remove all rules and
# pre-existing user defined chains before we implement new rules.
iptables -F
iptables -X
iptables -Z

iptables -t nat -F

# Allow local-only connections
iptables -A INPUT  -i lo -j ACCEPT

# Free output on any interface to any ip for any service
# (equal to -P ACCEPT)
iptables -A OUTPUT -j ACCEPT

# Permit answers on already established connections
# and permit new connections related to established ones
# (e.g. port mode ftp)
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Log everything else. What's Windows' latest exploitable vulnerability?
#iptables -A INPUT -j LOG --log-prefix "FIREWALL:INPUT "

# End $rc_base/rc.iptables
EOF
as_root chmod 700 /etc/rc.d/rc.iptables
# Add to list of installed programs on this system
echo "iptables-1.4.21" >> /list-$CHRISTENED"-"$SURNAME
#
