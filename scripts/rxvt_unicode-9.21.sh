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
#x_window_system
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gdk-pixbuf-2.31.5
#startup-notification-0.12
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep rxvt_unicode-9.21 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://dist.schmorp.de/rxvt-unicode/Attic/rxvt-unicode-9.21.tar.bz2
# md5sum:
echo "a9a06c608258c5fd247c3725d8f44582 rxvt-unicode-9.21.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf rxvt-unicode-9.21.tar.bz2
cd rxvt-unicode-9.21
./configure --prefix=/usr --enable-everything
make
#
as_root make install
cd ..
as_root rm -rf rxvt-unicode-9.21
#
# Add to installed list for this computer:
echo "rxvt_unicode-9.21" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Configuration
#
as_root tee -a /etc/X11/app-defaults/URxvt << "EOF"
URxvt*perl-ext: matcher
URxvt*urlLauncher: firefox
URxvt.background: black
URxvt.foreground: yellow
URxvt*font: xft:Monospace:pixelsize=12
EOF
#
as_root tee /usr/share/applications/urxvt.desktop << "EOF"
[Desktop Entry]
Encoding=UTF-8
Name=Rxvt-Unicode Terminal
Comment=Use the command line
GenericName=Terminal
Exec=urxvt 
Terminal=false
Type=Application
Icon=utilities-terminal
Categories=GTK;Utility;TerminalEmulator;
EOF
#
grep rxvt_unicode-9.21 /list-$CHRISTENED"-"$SURNAME > /dev/null &&
as_root tee -a /usr/share/applications/urxvt.desktop << "EOF"
#StartupNotify=true
EOF
as_root tee -a /usr/share/applications/urxvt.desktop << "EOF"
Keywords=console;command line;execute;
EOF
update-desktop-database -q
#
###################################################