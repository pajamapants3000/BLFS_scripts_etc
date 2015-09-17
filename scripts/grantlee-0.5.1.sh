#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for grantlee-0.5.1
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
#qt-4.8.7 
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
grep grantlee-0.5.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.grantlee.org/grantlee-0.5.1.tar.gz
# md5sum:
echo "775f22dac0953029b414ed3b7379098c grantlee-0.5.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf grantlee-0.5.1.tar.gz
cd grantlee-0.5.1
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release ..
make
#
as_root make install
cd ../..
as_root rm -rf grantlee-0.5.1
#
# Add to installed list for this computer:
echo "grantlee-0.5.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################