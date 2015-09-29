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
source blfs_profile
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep nvidia-352.21 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://download.nvidia.com/XFree86/Linux-x86_64/352.21/NVIDIA-Linux-x86_64-352.21-no-compat32.run
#
sh ./NVIDIA-Linux-x86_64-352.21-no-compat32.run --extract-only
cd NVIDIA-Linux-x86_64-352.21-no-compat32
patch -p1 < ../files/nvidia.patch
as_root ./nvidia-installer --accept-license
#
# You will be prompted to create a new xorg.conf file
#+ ... just hit enter (defaults to No)
as_root cp -v kernel/nvidia.ko         /lib/modules/$KVER/kernel/drivers/video/
as_root cp -v kernel/uvm/nvidia-uvm.ko /lib/modules/$KVER/kernel/drivers/video/
#cd ..
#as_root rm -rf NVIDIA-Linux-x86_64-352.21-no-compat32
#
# Add to installed list for this computer:
echo "NVIDIA-Linux-x86_64-352.21-no-compat32" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Configuration
#***************
#
as_root tee -a /etc/modprobe.d/blacklist << "EOF"
blacklist nouveau
EOF
#
as_root cp -v files/10-nvidia.conf /etc/X11/xorg.conf.d/
as_root chown root:root /etc/xorg.conf.d/10-nvidia.conf
as_root chmod 644 /etc/X11/xorg.conf.d/10-nvidia.conf
#
###################################################
