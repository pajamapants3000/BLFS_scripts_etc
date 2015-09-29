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
#libogg-1.3.2
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#valgrind-3.10.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep speex-1.2rc2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.us.xiph.org/releases/speex/speex-1.2rc2.tar.gz
# md5sum:
echo "6ae7db3bab01e1d4b86bacfa8ca33e81 speex-1.2rc2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Additional package info download:
wget http://downloads.us.xiph.org/releases/speex/speexdsp-1.2rc3.tar.gz
# md5sum:
echo "70d9d31184f7eb761192fd1ef0b73333 speexdsp-1.2rc3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf speex-1.2rc2.tar.gz
pushd speex-1.2rc2
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/speex-1.2rc2
make
#
as_root make install
#
cd ..
tar -xf speexdsp-1.2rc3.tar.gz
cd speexdsp-1.2rc3
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/speexdsp-1.2rc3
make
#
as_root make install
#
popd
as_root rm -rf speex-1.2rc2
#
# Add to installed list for this computer:
echo "speex-1.2rc2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################