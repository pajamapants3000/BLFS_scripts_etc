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
# End Recommended
# Begin Optional
#xmlto-0.0.26
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep giflib-5.1.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/giflib/giflib-5.1.1.tar.bz2
# md5sum:
echo "1c39333192712788c6568c78a949f13e giflib-5.1.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf giflib-5.1.1.tar.bz2
cd giflib-5.1.1
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
#
find doc \( -name Makefile\* -o -name \*.1 \
         -o -name \*.xml \) -exec as_root rm -v {} \;
as_root install -v -dm755 /usr/share/doc/giflib-5.1.1
as_root cp -v -R doc/* /usr/share/doc/giflib-5.1.1
cd ..
as_root rm -rf giflib-5.1.1
#
# Add to installed list for this computer:
echo "giflib-5.1.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################