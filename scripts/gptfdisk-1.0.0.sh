#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gptfdisk-1.0.0
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#popt-1.16
#icu-55.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gptfdisk-1.0.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/project/gptfdisk/gptfdisk/1.0.0/gptfdisk-1.0.0.tar.gz
# md5sum:
echo "2061f917af084215898d4fea04d8388f gptfdisk-1.0.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Recommended patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/gptfdisk-1.0.0-convenience-1.patch
tar -xvf gptfdisk-1.0.0.tar.gz
cd gptfdisk-1.0.0
patch -Np1 -i ../gptfdisk-1.0.0-convenience-1.patch
make
#
as_root make install
cd ..
as_root rm -rf gptfdisk-1.0.0
#
# Add to installed list for this computer:
echo "gptfdisk-1.0.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################