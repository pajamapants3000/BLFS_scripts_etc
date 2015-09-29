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
#fuse-2.9.4
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
#CONFIG_FUSE_FS
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep ntfs_3g_ntfsprogs-2015.3.14 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://tuxera.com/opensource/ntfs-3g_ntfsprogs-2015.3.14.tgz
# md5sum:
echo "8cd57768310e3b2be39b3191d808e241 ntfs-3g_ntfsprogs-2015.3.14.tgz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf ntfs-3g_ntfsprogs-2015.3.14.tgz
cd ntfs-3g_ntfsprogs-2015.3.14
./configure --prefix=/usr --disable-static --with-fuse=external
make
#
as_root make install
as_root ln -sv ../bin/ntfs-3g /sbin/mount.ntfs
as_root ln -sv ntfs-3g.8 /usr/share/man/man8/mount.ntfs.8
as_root chmod -v 4755 /sbin/mount.ntfs
cd ..
as_root rm -rf ntfs-3g_ntfsprogs-2015.3.14
#
as_root chmod -v 777 /mnt/usb
# Add to installed list for this computer:
echo "ntfs_3g_ntfsprogs-2015.3.14" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################