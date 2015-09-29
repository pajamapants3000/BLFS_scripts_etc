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
grep lxqt_close_opt /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
as_root mv /opt/lxqt{,-0.9.1}
as_root ln -sfv lxqt-0.9.1 /opt/lxqt
#
as_root ln -svfn /opt/lxqt/share/lxqt /usr/share/lxqt
for i in /opt/lxqt/share/applications/*
do
  as_root ln -svf $i /usr/share/applications/
done
unset i
# Add to installed list for this computer:
echo "lxqt_close_opt" >> /list-$CHRISTENED"-"$SURNAME
#
as_root sed -i "s/\(^Exec=.*startlxqt\)/\1-wrapper/" \
    /usr/share/xsessions/lxqt.desktop
as_root install -Dm755 -v -o root -g root files/startlxqt-wrapper \
    $LXQT_PREFIX/bin/startlxqt-wrapper
#
###################################################

