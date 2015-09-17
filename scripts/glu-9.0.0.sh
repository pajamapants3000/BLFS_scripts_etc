#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for glu-9.0.0
#
# Dependencies
#**************
# Begin Required
#mesa-10.4.5
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
grep glu-9.0.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.freedesktop.org/pub/mesa/glu/glu-9.0.0.tar.bz2
# md5sum:
echo "be9249132ff49275461cf92039083030 glu-9.0.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf glu-9.0.0.tar.bz2
cd glu-9.0.0
./configure --prefix=$XORG_PREFIX --disable-static
make
#
as_root make install
cd ..
as_root rm -rf glu-9.0.0
#
# Add to installed list for this computer:
echo "glu-9.0.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################