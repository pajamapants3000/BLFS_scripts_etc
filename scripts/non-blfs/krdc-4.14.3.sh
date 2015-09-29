#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source blfs_profile
if (cat /list-${CHRISTENED}-${SURNAME} | grep "qt-4" > /dev/null); then
    if (cat /list-${CHRISTENED}-${SURNAME} | grep "qt-5" > /dev/null); then
        if (echo $PATH | grep qt5); then
            QTVERSET=5
            source setqt4
        elif ! (echo $PATH | grep qt4); then
            source setqt4
        fi
    elif ! (echo $PATH | grep qt4); then
        source setqt4
    fi
else
    echo "keepassx-0.4.3 will not build without qt4"
    echo "Please install qt4 and try installing keepassx-0.4.3 again"
    exit E_MISSINGDEP
fi
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
#qt-5.5.0
#kde4_core
#automoc-0.9.88
# End Required
# Begin Recommended (Runtime)
#freerdp-git
#telepathy-qt
# End Recommended (Runtime)
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
grep "krdc-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://mirrors-usa.go-parts.com/kde/stable/4.14.3/src/krdc-4.14.3.tar.xz
# FTP/alt Download:
#wget http://kde.mirrors.tds.net/pub/kde/stable/4.14.3/src/krdc-4.14.3.tar.xz
#
# md5sum:
echo "7e796905eb8579e457c6ead2f1c21525 krdc-4.14.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf krdc-4.14.3.tar.xz
cd krdc-4.14.3
mkdir -v build
cd       build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX \
      -DCMAKE_BUILD_TYPE=Release         \
      -Wno-dev ..
make -j${PARALLEL}
#
as_root make -j${PARALLEL} install
cd ../..
as_root rm -rf krdc-4.14.3
#
# Add to installed list for this computer:
echo "krdc-4.14.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

