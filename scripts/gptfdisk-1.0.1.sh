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
#popt-1.16
#icu-56.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gptfdisk-1.0.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/project/gptfdisk/gptfdisk/1.0.1/gptfdisk-1.0.1.tar.gz
# md5sum:
echo "d7f3d306b083123bcc6f5941efade586 gptfdisk-1.0.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Recommended patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/gptfdisk-1.0.1-convenience-1.patch
tar -xvf gptfdisk-1.0.1.tar.gz
cd gptfdisk-1.0.1
patch -Np1 -i ../gptfdisk-1.0.1-convenience-1.patch
make POPT=1 ICU=1
#
as_root make POPT=1 install
cd ..
as_root rm -rf gptfdisk-1.0.1
#
# Add to installed list for this computer:
echo "gptfdisk-1.0.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
