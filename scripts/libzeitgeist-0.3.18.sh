#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libzeitgeist-0.3.18
#
# Dependencies
#**************
# Begin Required
#glib-2.44.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gtk_doc-1.24
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libzeitgeist-0.3.18 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://launchpad.net/libzeitgeist/0.3/0.3.18/+download/libzeitgeist-0.3.18.tar.gz
#
# md5sum:
echo "d63a37295d01a58086d0d4ae26e604c2 libzeitgeist-0.3.18.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libzeitgeist-0.3.18.tar.gz
cd libzeitgeist-0.3.18
sed -i  "s|/doc/libzeitgeist|&-0.3.18|" Makefile.in
./configure --prefix=/usr --disable-static
make
#
as_root make install
cd ..
as_root rm -rf libzeitgeist-0.3.18
#
# Add to installed list for this computer:
echo "libzeitgeist-0.3.18" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
