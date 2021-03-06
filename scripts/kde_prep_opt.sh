#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
export KDE_PREFIX=/opt/kde
as_root cp -v files/etc/profile.d/kde.sh /etc/profile.d/
as_root chown -v root:root /etc/profile.d/kde.sh
as_root chmod -v 755 /etc/profile.d/kde.sh
as_root ln -sv /etc/profile.d/kde.sh /etc/profile.d/active/70-kde.sh
as_root tee -a /etc/profile.d/bash_envar.sh << EOF
# Begin kde4 addition
KDE_PREFIX=$KDE_PREFIX
# End kde4 addition
#
EOF
#
#
as_root tee -a /etc/ld.so.conf << EOF
# Begin kde addition
/opt/kde/lib
# End kde addition
#
EOF
#
as_root install -d $KDE_PREFIX/share
as_root ln -svf /usr/share/dbus-1 $KDE_PREFIX/share
as_root ln -svf /usr/share/polkit-1 $KDE_PREFIX/share
#
# NOW SOURCE IT!!!
#
