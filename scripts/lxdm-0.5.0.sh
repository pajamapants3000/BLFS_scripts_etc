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
#gtk+-2.24.28
#iso_codes-3.59
#librsvg-2.40.10
# End Required
# Begin Recommended
#consolekit-0.4.6
#linux_pam-1.2.1
# End Recommended
# Begin Optional
#gtk+-3.16.6
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "lxdm-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/lxdm/lxdm-0.5.0.tar.xz
#
# md5sum:
echo "a51686720e606ca456d7f56ae4159d1f lxdm-0.5.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lxdm-0.5.0.tar.xz
cd lxdm-0.5.0
cat > pam/lxdm << "EOF"
#%PAM-1.0
auth        required    pam_unix.so
auth        requisite   pam_nologin.so
account     required    pam_unix.so
password    required    pam_unix.so
session     required    pam_unix.so
EOF
#
sed -i 's:sysconfig/i18n:profile.d/i18n.sh:g' data/lxdm.in
sed -i 's:/etc/xprofile:/etc/profile:g' data/Xsession
sed -e 's/^bg/#&/'        \
    -e '/reset=1/ s/# //' \
    -e 's/logou$/logout/' \
    -e "/arg=/a arg=$XORG_PREFIX/bin/X" \
    -i data/lxdm.conf.in
#
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --with-pam        \
            --with-systemdsystemunitdir=no
make
#
as_root make install
cd ..
as_root rm -rf lxdm-0.5.0
#
# Add to installed list for this computer:
echo "lxdm-0.5.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
