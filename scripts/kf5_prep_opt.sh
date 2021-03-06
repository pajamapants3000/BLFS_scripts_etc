#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
KF5_PREFIX=/opt/kf5

as_root install -Dm644 -o root -g root files/etc/profile.d/kf5.sh /etc/profile.d/kf5.sh
as_root install -Dm644 -o root -g root files/usr/bin/setkf5 /usr/bin/setkf5
as_root tee -a /etc/profile.d/bash_envar.sh << "EOF"
# Begin kf5 addition
KF5_PREFIX=$KF5_PREFIX
# End kf5 addition
#
EOF
#
as_root install -v -dm755           $KF5_PREFIX/{etc,share}
as_root tee -a /etc/ld.so.conf << "EOF"
# Begin KF5 addition
/opt/kf5/lib
# End KF5 addition
#
EOF
as_root ldconfig
#
as_root install -v -dm755           $KF5_PREFIX/{etc,share}
as_root ln -sfv /etc/dbus-1         $KF5_PREFIX/etc
as_root ln -sfv /usr/share/dbus-1   $KF5_PREFIX/share

as_root install -v -dm755                $KF5_PREFIX/share/icons
as_root ln -sfv /usr/share/icons/hicolor $KF5_PREFIX/share/icons
#

