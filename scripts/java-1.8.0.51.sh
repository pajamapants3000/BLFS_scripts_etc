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
grep "java-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
if [ $ARCH = "x86_64" ]; then
# Download (x86_64):
wget http://anduin.linuxfromscratch.org/files/BLFS/OpenJDK-1.8.0.51/OpenJDK-1.8.0.51-x86_64-bin.tar.xz
# md5sum:
echo "91331d899c4f42dfe5f4016e173cafab OpenJDK-1.8.0.51-x86_64-bin.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
elif [ $ARCH = "x86" ]; then
# Download (x86):
wget http://anduin.linuxfromscratch.org/files/BLFS/OpenJDK-1.8.0.51/OpenJDK-1.8.0.51-i686-bin.tar.xz
# md5sum:
echo "752a869d9dfb6c3a978f59f87eedafbf OpenJDK-1.8.0.51-x86_64-bin.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
else
    echo "ARCH not set; modify blfs_profile to set ARCH to either \"x86\" or \"x86_64\""
fi
#
tar -xvf OpenJDK-1.8.0.51-x86_64-bin.tar.xz
cd OpenJDK-1.8.0.51-x86_64-bin
as_root install -vdm755 /opt/OpenJDK-1.8.0.51-bin
as_root mv -v * /opt/OpenJDK-1.8.0.51-bin
as_root chown -R root:root /opt/OpenJDK-1.8.0.51-bin
#
# Install versioned symlink
as_root ln -sfn OpenJDK-1.8.0.51-bin /opt/jdk
#
cd ..
as_root rm -rf OpenJDK-1.8.0.51-x86_64-bin
#
# Add to installed list for this computer:
echo "java-1.8.0.51" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Configuration
#
as_root cp files/etc/profile.d/openjdk.sh /etc/profile.d/
as_root chown root:root /etc/profile.d/openjdk.sh
as_root chmod 644 /etc/profile.d/openjdk.sh
as_root ln -sv /etc/profile.d/openjdk.sh /etc/profile.d/active/88-openjdk.sh
#
as_root tee -a /etc/man_db.conf << "EOF"
# Begin Java addition
MANDATORY_MANPATH     /opt/jdk/man
MANPATH_MAP           /opt/jdk/bin     /opt/jdk/man
MANDB_MAP             /opt/jdk/man     /var/cache/man/jdk
# End Java addition
EOF
#
as_root mkdir -p /var/cache/man
as_root mandb -c /opt/jdk/man
#
######################################################################
