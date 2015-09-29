#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source blfs_profile
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#mdadm-3.3.4
#xfsprogs-3.2.4
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "LVM2-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://sources.redhat.com/pub/lvm2/releases/LVM2.2.02.129.tgz
# md5sum:
echo "b3f4c273a30b316678755cec2a129718 LVM2.2.02.129.tgz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf LVM2.2.02.129.tgz
pushd LVM2.2.02.129
./configure --prefix=/usr       \
            --exec-prefix=      \
            --with-confdir=/etc \
            --enable-applib     \
            --enable-cmdlib     \
            --enable-pkgconfig  \
            --enable-udev_sync
make -j${PARALLEL}
# Test (not really worth it):
#
#make -j${PARALLEL} -k check 2>&1 | tee ../logs/"$(basename $0)"-log; \
#STAT=${PIPESTATUS[0]}; ( exit 0 )
#if (( STAT )); then
#    echo "Some tests failed; log in ../$(basename $0)-log"
#    echo "Pull up another terminal and check the output"
#    echo "Shall we proceed? (say "'"yes"'" or "'"y"'" to proceed)"
#    read PROCEED
#    [ "$PROCEED" = "y" ] || [ "$PROCEED" = "yes" ]
#fi
#
as_root make -j${PARALLEL} install
popd
as_root rm -rf LVM2.2.02.129
#
# Add to installed list for this computer:
echo "LVM2-2.02.129" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
