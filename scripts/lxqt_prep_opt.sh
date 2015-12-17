#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
LXQT_PREFIX=/opt/lxqt
#
# Dependencies
#**************
# Begin Required
#qt-5.5.0
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
grep lxqt_prep_opt /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Set up the directory structure in /opt
as_root install -vdm755 /opt/lxqt/{bin,lib,share/man}
as_root ln -sfv -v /usr/share/dbus-1 $LXQT_PREFIX/share/
as_root ln -sfv -v /usr/share/polkit-1 $LXQT_PREFIX/share/
#
# Modify environment (requires refresh! - source /etc/profile)
as_root install -Dm755 -o root -g root files/etc/profile.d/lxqt.sh /etc/profile.d/lxqt.sh
as_root ln -sfv /etc/profile.d/lxqt.sh /etc/profile.d/active/70-WM.sh
as_root install -Dm755 -o root -g root files/usr/bin/setlxqt /usr/bin/setlxqt
as_root tee -a /etc/profile.d/bash_envar.sh << "EOF"
# Begin lxqt addition
LXQT_PREFIX=/opt/lxqt
# End lxqt addition
#
EOF
#
as_root tee -a /etc/ld.so.conf << "EOF"
# Begin LXQt addition
/opt/lxqt/lib
# End LXQt addition
#
EOF
as_root /sbin/ldconfig
#
as_root install -v -dm755                /opt/lxqt/share/icons
as_root ln -sfv /usr/share/icons/hicolor /opt/lxqt/share/icons
#
# Add to installed list for this computer:
echo "lxqt_prep_opt" >> /list-$CHRISTENED"-"$SURNAME
#
##################################
#
# DON'T FORGET TO...
#
#source /etc/profile
#
#################################
