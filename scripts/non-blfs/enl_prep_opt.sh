#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for enl_prep_opt
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
grep "enl_prep_opt" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
ENL_PREFIX=/opt/enlightenment
#
as_root install -Dm644 -o root -g root \
        files/enlightenment.sh /etc/profile.d/enlightenment.sh
as_root install -Dm644 -o root -g root files/setenl /usr/bin/setenl
as_root tee -a /etc/profile.d/bash_alias << "EOF"
# Begin Enlightenment addition
alias setenl='source setenl'
# End Enlightenment addition
EOF
as_root tee -a /etc/profile.d/bash_envar.sh << "EOF"
# Begin Enlightenment addition
ENL_PREFIX=/opt/enlightenment
# End Enlightenment addition
#
EOF
#
as_root install -v -dm755 $ENL_PREFIX/{bin,include,lib/pkgconfig,etc,share}
as_root ln -sfv -v /usr/share/dbus-1 $ENL_PREFIX/share/
as_root ln -sfv -v /usr/share/polkit-1 $ENL_PREFIX/share/
as_root tee -a /etc/ld.so.conf << "EOF"
# Begin Enlightenment addition
/opt/enlightenment/lib
# End Enlightenment addition
#
EOF
as_root ldconfig
#
tee enlightenment.sh << "EOF"
# Enlightenment installation environment
# Just to be sure!
export ENL_PREFIX=/opt/enlightenment
export PATH=/opt/enlightenment/bin:"$PATH"
export PKG_CONFIG_PATH=/opt/enlightenment/lib/pkgconfig:"$PKG_CONFIG_PATH"
export LD_LIBRARY_PATH=/opt/enlightenment/lib:"$LD_LIBRARY_PATH"
export CFLAGS="-O3 -ffast-math -march=native"
EOF
# Add to installed list for this computer:
echo "enl_prep_opt" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
