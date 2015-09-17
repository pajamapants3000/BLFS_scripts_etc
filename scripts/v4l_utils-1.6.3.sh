#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for v4l_utils-1.6.3
#
# Dependencies
#**************
# Begin Required
#glu-9.0.0
#libjpeg_turbo-1.4.1
#mesa-10.6.5
# End Required
# Begin Recommended
#alsa_lib-1.0.29
#qt-4.8.7
#qt-5.5.0
# End Recommended
# Begin Optional
#doxygen-1.8.10
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "v4l_utils-1.6.3" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.linuxtv.org/downloads/v4l-utils/v4l-utils-1.6.3.tar.bz2
# md5sum:
echo "307858616be6374f63bf946307f15a7f v4l-utils-1.6.3.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf v4l-utils-1.6.3.tar.bz2
cd v4l-utils-1.6.3
./configure --prefix=/usr     \
            --sysconfdir=/etc \
            --disable-static
make
#
as_root make install
cd ..
as_root rm -rf v4l-utils-1.6.3
#
# Add to installed list for this computer:
echo "v4l_utils-1.6.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

