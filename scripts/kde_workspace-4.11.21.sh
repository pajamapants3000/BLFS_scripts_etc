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
#kactivities-4.13.3
#qimageblitz-0.0.6
#xcb-util-image-0.4.0
#xcb-util-renderutil-0.3.9
#xcb-util-keysyms-0.4.0
#xcb-util-wm-0.4.1
# End Required
# Begin Recommended
#kdepimlibs-4.14.10
#boost-1.59.0
#freetype-2.6
#pciutils-3.3.1
#consolekit-0.4.6
# End Recommended
# Begin Optional
#linux_pam-1.2.1
#libusb-1.0.19
#networkmanager-1.0.6
#lm_sensors-3.4.0
#qjson-0.8.1
#pykde4
#googlegadgets
#prison
#libraw1394
#gpsd
#xmms
#libqalculate
#wayland
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kde_workspace-4.11.21 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/kde-workspace-4.11.21.tar.xz
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/applications/15.04.3/src/kde-workspace-4.11.21.tar.xz
#
# md5sum:
echo "bd7fa9c894dda23e8d06fc6a49a561cf kde-workspace-4.11.21.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kde-workspace-4.11.21.tar.xz
cd kde-workspace-4.11.21
#
if ! (cat /etc/group | grep kdm > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -g 37 kdm
    as_root useradd -c "KDM_Daemon_Owner" -d /var/lib/kdm -g kdm \
            -u 37 -s /bin/false kdm
    pathremove /usr/sbin
fi
as_root install -o kdm -g kdm -dm755 /var/lib/kdm
#
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX           \
      -DSYSCONF_INSTALL_DIR=/etc                   \
      -DCMAKE_BUILD_TYPE=Release                   \
      -DINSTALL_PYTHON_FILES_IN_PYTHON_PREFIX=TRUE \
      -Wno-dev ..
make
#
as_root make install
as_root mkdir -p /usr/share/xsessions
as_root ln -sf $KDE_PREFIX/share/apps/kdm/sessions/kde-plasma.desktop \
       /usr/share/xsessions/kde-plasma.desktop
cd ../..
as_root rm -rf kde-workspace-4.11.21
#
# Add to installed list for this computer:
echo "kde_workspace-4.11.21" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
#
as_root tee -a /etc/pam.d/kde << "EOF"
# Begin /etc/pam.d/kde

auth     requisite      pam_nologin.so
auth     required       pam_env.so

auth     required       pam_succeed_if.so uid >= 1000 quiet
auth     include        system-auth

account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/kde
EOF
as_root tee /etc/pam.d/kde-np << "EOF"
# Begin /etc/pam.d/kde-np

auth     requisite      pam_nologin.so
auth     required       pam_env.so

auth     required       pam_succeed_if.so uid >= 1000 quiet
auth     required       pam_permit.so

account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/kde-np
EOF
as_root tee /etc/pam.d/kscreensaver << "EOF"
# Begin /etc/pam.d/kscreensaver

auth    include system-auth
account include system-account

# End /etc/pam.d/kscreensaver
EOF
#
###################################################
