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
#shared_mime_info-1.4
#boost-1.59.0
#sqlite-3.8.11.1
##mariadb-10.0.20
##mysql
##postgresql-9.4.4
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#soprano
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep akonadi-1.13.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/akonadi/src/akonadi-1.13.0.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/akonadi/src/akonadi-1.13.0.tar.bz2
#
# md5sum:
echo "84eb2e471bd6bdfe54a2a2f1d858c07d akonadi-1.13.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf akonadi-1.13.0.tar.bz2
cd akonadi-1.13.0
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX  \
      -DCMAKE_BUILD_TYPE=Release          \
      -DINSTALL_QSQLITE_IN_QT_PREFIX=TRUE \
      -DWITH_SOPRANO=FALSE                \
      -DDATABASE_BACKEND=SQLITE           \
      -Wno-dev ..
make
# Test - 19 fail in console, 7 fail in X session with dbus-launch:
#make test
#
as_root make install
cd ../..
as_root rm -rf akonadi-1.13.0
#
# Add to installed list for this computer:
echo "akonadi-1.13.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
