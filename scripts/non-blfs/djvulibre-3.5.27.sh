#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Updated 07/19/2015
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#tiff-4.0.5
#libjpeg_turbo-1.4.1
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
grep djvulibre-3.5.27 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/djvu/files/DjVuLibre/3.5.27/djvulibre-3.5.27.tar.gz
# md5sum:
echo "aa4ed331f669f5a72e3c0d7f9196c4e6 djvulibre-3.5.27.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf djvulibre-3.5.27.tar.gz
cd djvulibre-3.5.27
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf djvulibre-3.5.27
#
# Add to installed list for this computer:
echo "djvulibre-3.5.27" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################