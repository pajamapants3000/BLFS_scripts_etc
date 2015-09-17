#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for qca-2.1.0
#
# Dependencies
#**************
# Begin Required
#certdata
#cmake-3.3.1
#qt-4.8.7
#which-2.21
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#cyrus_sasl-2.1.26
#gnupg-2.1.7
#libgcrypt-1.6.3
#libgpg_error-1.20
#nss-3.20
#nspr-4.10.9
#openssl-1.0.2d
#p11_kit-0.23.1
#qt-5.5.0
#doxygen-1.8.10
#which-2.21
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep qca-2.1.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://delta.affinix.com/download/qca/2.0/qca-2.1.0.tar.gz
# md5sum:
echo "c2b00c732036244701bae4853a2101cf qca-2.1.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf qca-2.1.0.tar.gz
cd qca-2.1.0
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$QT4DIR            \
      -DCMAKE_BUILD_TYPE=Release                \
      -DQT4_BUILD=ON                            \
      -DQCA_MAN_INSTALL_DIR:PATH=/usr/share/man \
      ..   
make
# Test:
make test
#
as_root make install
cd ../..
as_root rm -rf qca-2.1.0
#
# Add to installed list for this computer:
echo "qca-2.1.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################