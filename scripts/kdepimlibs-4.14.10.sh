#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kdepimlibs-4.14.10
#
# Dependencies
#**************
# Begin Required
#kdelibs-4.14.10
#libxslt-1.1.28
#gpgme-1.6.0
#libical-1.0.1
#akonadi-1.13.0
#cyrus_sasl-2.1.26
#boost-1.59.0
#qjson-0.8.1
# End Required
# Begin Recommended
#openldap-2.4.42
# End Recommended
# Begin Optional
#openssl-1.0.2d
#prison
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep kdepimlibs-4.14.10 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/applications/15.04.3/src/kdepimlibs-4.14.10.tar.xz
# md5sum:
echo "098c975fb970621dc8382ed3c28de0eb kdepimlibs-4.14.10.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kdepimlibs-4.14.10.tar.xz
cd kdepimlibs-4.14.10
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf kdepimlibs-4.14.10
#
# Add to installed list for this computer:
echo "kdepimlibs-4.14.10" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################