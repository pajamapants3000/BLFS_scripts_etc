#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Modify the KDE folder to be versioned and link the unversioned
#+version to it
#
mv /opt/kde{,-15.04.2}
ln -svf kde-15.04.2 /opt/kde
#
# Create a temporary .xinitrc to test KDE; save current one
cp -v files/.xinitrc-kde $HOME/
#
# Optionally, set KDE to runlevel 5
as_root tee -a /etc/inittab << EOF
kd:5:respawn:/opt/kde/bin/kdm
EOF
#
# KDE requires running user to have full access to /tmp and /var/tmp
as_root chmod 1777 /tmp
as_root chmod 1777 /var/tmp
# Also optionally, set runlevel 5 to default (KDE starts on boot)
#as_root sed -i 's#id:3:initdefault:#id:5:initdefault:#' /etc/inittab
#
# Set the xsessions file to run the startkde-wrapper
as_root sed -i "s/\(^Exec=.*startkde\)/\1-wrapper/" \
    /usr/share/xsessions/kde-plasma.desktop
as_root install -Dm755 -v -o root -g root files/startkde4-wrapper \
    $KF5_PREFIX/bin/startkde-wrapper
#
# Later on, you may want to install other versions of KDE. To do that,
# just remove the symlink and use /opt/kde as the prefix again (KDE must
# not be started). Which version of KDE you use depends only on where
# the symlink points to. No other reconfiguration will be needed. 
####################################################
