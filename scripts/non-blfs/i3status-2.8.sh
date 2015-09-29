#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Dependencies: See separate i3.DEPENDS file, or DEPENDS in root folder of
#   package.
#
# Default prefix is /usr
#
# Check for previous installation:
PROCEED="yes"
grep i3status-2.8 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://i3wm.org/i3status/i3status-2.8.tar.bz2
# md5sum:
#
##
tar -xvf i3status-2.8.tar.bz2
cd i3status-2.8
patch -p1 < ../patches/i3status-2.8-patch.diff
source ../blfs_profile
sed -i 's/IFACE/'$IFACE/g i3status.conf contrib/measure-net-speed.bash man/i3status.1
export STATSPATH=$(find /sys/devices -name statistics | grep $IFACE)
sed -i s@STATSPATH@$STATSPATH@ contrib/measure-net-speed.bash
cp contrib/* ~/bin/
chmod +x ~/bin/measure-net-speed*
make
#  Install seems to require setcap on my last install
#  This requires sbin to be on the path. This may
#+ be removed again later, never had this problem
#+ the last few times I installed before...
pathappend /usr/sbin
as_root make install
pathremove /usr/sbin
cd ..
as_root rm -rf i3status-2.8
# Add to list of installed programs on this system
echo "i3status-2.8" >> /list-$CHRISTENED"-"$SURNAME
#
# May want to go back and edit source before installing.
#
# Install i3status for optimal performance (plus no errors!)
#
########################################################
