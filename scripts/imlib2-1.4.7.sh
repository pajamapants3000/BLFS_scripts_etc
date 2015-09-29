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
#xorg_libraries
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#libpng-1.6.18
#libjpeg-turbo-1.4.1
#tiff-4.0.5
#giflib-5.1.1
#libid3tag
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep imlib2-1.4.7 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/enlightenment/files/imlib2-src/1.4.7/imlib2-1.4.7.tar.bz2
# md5sum:
echo "f2f1418c376da6125453f90f2d58d938 imlib2-1.4.7.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf imlib2-1.4.7.tar.bz2
cd imlib2-1.4.7
./configure --prefix=/usr --disable-static
make
#
as_root make install
as_root install -v -m755 -d /usr/share/doc/imlib2-1.4.7
as_root install -v -m644    doc/{*.gif,index.html} \
                    /usr/share/doc/imlib2-1.4.7
cd ..
as_root rm -rf imlib2-1.4.7
#
# Add to installed list for this computer:
echo "imlib2-1.4.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################