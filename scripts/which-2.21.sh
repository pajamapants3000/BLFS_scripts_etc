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
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep which-2.21 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnu.org/gnu/which/which-2.21.tar.gz
# FTP/alt Download:
#wget ftp://ftp.gnu.org/gnu/which/which-2.21.tar.gz
#
# md5sum:
echo "097ff1a324ae02e0a3b0369f07a7544a which-2.21.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf which-2.21.tar.gz
cd which-2.21
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf which-2.21
#
# Add to installed list for this computer:
echo "which-2.21" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################