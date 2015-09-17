#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libtorrent_rasterbar-1.0.6
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
grep "libtorrent_rasterbar-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://github.com/arvidn/libtorrent/releases/download/libtorrent-1_0_6/libtorrent-rasterbar-1.0.6.tar.gz
# md5sum:
#echo "XXX libtorrent-rasterbar-1.0.6.tar.xz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libtorrent-rasterbar-1.0.6.tar.xz
cd libtorrent-rasterbar-1.0.6
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make -j${PARALLEL}
#
as_root make -j${PARALLEL} install
cd ../..
as_root rm -rf libtorrent-rasterbar-1.0.6
#
# Add to installed list for this computer:
echo "libtorrent_rasterbar-1.0.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#

