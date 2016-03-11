#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source ${HOME}/.blfs_profile
#
# Dependencies
#**************
# Begin Required
#Xorg Applications
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#valgrind-3.10.1
#man2html
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xterm-320 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://invisible-island.net/xterm/xterm-320.tgz
# md5sum:
echo "0d7f0e6390d132ae59876b3870e5783d xterm-320.tgz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xterm-320.tgz
cd xterm-320
sed -i '/v0/{n;s/new:/new:kb=^?:/}' termcap
printf '\tkbs=\\177,\n' >> terminfo
TERMINFO=/usr/share/terminfo \
./configure $XORG_CONFIG     \
    --with-app-defaults=/etc/X11/app-defaults
make
#
as_root make install
as_root make install-ti
cd ..
as_root rm -rf xterm-320
#
as_root tee -a /etc/X11/app-defaults/XTerm << "EOF"
*VT100*locale: true
*VT100*faceName: Monospace
*VT100*faceSize: 10
*backarrowKeyIsErase: true
*ptyInitialErase: true
EOF
# Add to installed list for this computer:
echo "xterm-320" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################