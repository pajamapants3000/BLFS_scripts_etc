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
#cmake-3.3.1
#qt-5.5.0
# End Required
# Begin Required Runtime
#consolekit-0.4.6
# End Required Runtime
# Begin Recommended
#linux_pam-1.2.1
# End Recommended
# Begin Optional
#docutils
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "sddm-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://anduin.linuxfromscratch.org/sources/other/sddm-0.11.0.tar.gz
#
# md5sum:
echo "e110a7683867400dc9484d4744fd41dd sddm-0.11.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
if ! (cat /etc/group | grep sddm > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -g 64 sddm
    as_root useradd -c "SDDM_Daemon" -d /var/lib/sddm \
            -u 64 -g sddm -G video -s /bin/false sddm
    pathremove /usr/sbin
fi
#
tar -xvf sddm-0.11.0.tar.xz
cd sddm-0.11.0
mkdir -v build
cd       build
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release  \
      -DENABLE_JOURNALD=OFF       \
      -DBUILD_MAN_PAGES=OFF       \
      -Wno-dev ..
make
#
as_root make install
as_root install -v -dm755 -o sddm -g sddm /var/lib/sddm
cd ../..
as_root rm -rf sddm-0.11.0
#
# Add to installed list for this computer:
echo "sddm-0.11.0" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-sddm
cd ..
#
###################################################
#
# Configuration with pam
for file in sddm sddm-autologin sddm-greeter; do
    as_root cp -v files/$file /etc/pam.d/
    as_root chown root:root /etc/pam.d/$file
    as_root chmod 644 /etc/pam.d/$file
done
#
# Change default runlevel to 5 to start automatically
#cp -v /etc/inittab{,-orig} &&
#sed -i '/initdefault/ s/3/5/' /etc/inittab
#
###################################################
