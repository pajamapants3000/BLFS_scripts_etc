#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xorg_server-1.17.2
#
# Dependencies
#**************
# Begin Required
#openssl-1.0.2d
#nettle-3.1.1
#libgcrypt-1.6.3
#pixman-0.32.6
#Xorg Fonts
#xkeyboard_config-2.15
# End Required
# Begin Recommended
#libepoxy-1.3.1
#xcb_util_keysyms-0.4.0 
# End Recommended
# Begin Optional
#acpid-2.0.23
#oxygen-1.8.10
#fop-1.1
#ghostscript-9.16
#xcb_util_image-0.4.0
#xcb_util_renderutil-0.3.9
#xcb_util_wm-0.4.1
#xmlto-0.0.26
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xorg_server-1.17.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.x.org/pub/individual/xserver/xorg-server-1.17.2.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.x.org/pub/individual/xserver/xorg-server-1.17.2.tar.bz2
#
# md5sum:
echo "397e405566651150490ff493e463f1ad xorg-server-1.17.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/xorg-server-1.17.2-add_prime_support-1.patch
#
tar -xvf xorg-server-1.17.2.tar.bz2
cd xorg-server-1.17.2
patch -Np1 -i ../xorg-server-1.17.2-add_prime_support-1.patch
./configure $XORG_CONFIG            \
           --enable-glamor          \
           --enable-install-setuid  \
           --enable-suid-wrapper    \
           --disable-systemd-logind \
           --with-xkb-output=/var/lib/xkb
make
# Test:
make check
#
as_root make install
as_root mkdir -pv /etc/X11/xorg.conf.d
as_root tee -a /etc/sysconfig/createfiles << "EOF"
/tmp/.ICE-unix dir 1777 root root
/tmp/.X11-unix dir 1777 root root
EOF
cd ..
as_root rm -rf xorg-server-1.17.2
#
# Add to installed list for this computer:
echo "xorg_server-1.17.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
