#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for exo-0.10.6
#
# Dependencies
#**************
# Begin Required
#libxfce4ui-4.12.1
#libxfce4util-4.12.1
#uri-1.69
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
grep exo-0.10.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/exo/0.10/exo-0.10.6.tar.bz2
# FTP/alt Download:
#wget XXX
#
# md5sum:
echo "895e4f38d2cfe58d69679e2902a335a5 exo-0.10.6.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf exo-0.10.6.tar.bz2
cd exo-0.10.6
./configure --prefix=/usr --sysconfdir=/etc
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf exo-0.10.6
#
# Add to installed list for this computer:
echo "exo-0.10.6" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################