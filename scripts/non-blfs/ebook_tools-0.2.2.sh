#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
#libzip-1.0.1
#libxml2-2.9.2
#cmake-3.3.1
# End Required
# Begin Recommended
##clit
#convertlit
#zip
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
grep ebook_tools-0.2.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/ebook-tools/files/ebook-tools/0.2.2/ebook-tools-0.2.2.tar.gz
#
tar -xvf ebook-tools-0.2.2.tar.gz
cd ebook-tools-0.2.2
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make
#
as_root make install
cd ../..
as_root rm -rf ebook-tools-0.2.2
#
# Add to installed list for this computer:
echo "ebook_tools-0.2.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
