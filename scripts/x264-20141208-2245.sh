#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for x264_snapshot-20141208-2245
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#yasm-1.3.0
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
grep x264_snapshot-20141208-2245 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20141208-2245-stable.tar.bz2
# md5sum:
echo "f43e49099d7e8b572595429b9bfec636 x264-snapshot-20141208-2245-stable.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf x264-snapshot-20141208-2245-stable.tar.bz2
cd x264-snapshot-20141208-2245-stable
./configure --prefix=/usr \
            --enable-shared \
            --disable-cli
make
#
as_root make install
cd ..
as_root rm -rf x264-snapshot-20141208-2245-stable
#
# Add to installed list for this computer:
echo "x264_snapshot-20141208-2245" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
