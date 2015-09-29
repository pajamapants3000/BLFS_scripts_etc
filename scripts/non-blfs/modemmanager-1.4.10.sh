#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
#glib-2.44.1
# End Required
# Begin Recommended
#libmbim-1.12.2
#libqmi-1.12.6
#vala-0.28.1
#polkit-0.113
# Also looks for systemd but seems to compile without it.
# End Recommended
# Begin Optional
#gtk_doc-1.24
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep modemmanager-1.4.10 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.freedesktop.org/software/ModemManager/ModemManager-1.4.10.tar.xz
#
tar -xvf ModemManager-1.4.10.tar.xz
cd ModemManager-1.4.10
# build without libqmi or libmbim with e.g. --without-mbim
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf ModemManager-1.4.10
#
# Add to installed list for this computer:
echo "modemmanager-1.4.10" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
