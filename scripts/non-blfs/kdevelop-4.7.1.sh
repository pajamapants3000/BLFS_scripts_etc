#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kdevelop-4.7.1
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
if [ $QTDIR = $QT5DIR ]; then
    source setqt4
    QTMOD=1
fi
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "kdevelop-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://kde.mirrors.hoobly.com/stable/kdevelop/4.7.1/src/kdevelop-4.7.1.tar.xz
# FTP/alt Download:
#wget http://mirrors-usa.go-parts.com/kde/stable/kdevelop/4.7.1/src/kdevelop-4.7.1.tar.xz
#
# md5sum:
echo "dc7e6259a999bd34ce644ffea4727e76 kdevelop-4.7.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kdevelop-4.7.1.tar.xz
cd kdevelop-4.7.1
mkdir -v build
cd       build
cmake -DCMAKE_PREFIX_PATH=/opt/kdevelop4    \
      -DCMAKE_INSTALL_PREFIX=/opt/kdevelop4 \
      ..
make
#
as_root make install
cd ../..
as_root rm -rf kdevelop-4.7.1
#
# Add to installed list for this computer:
echo "kdevelop-4.7.1" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Configuration
as_root cp -v files/kdevelop.sh /etc/profile.d
as_root chown root:root /etc/profile.d/kdevelop.sh
as_root chmod 644 /etc/profile.d/kdevelop.sh
as_root ln -sv /etc/profile.d/kdevelop.sh /etc/profile.d/active/78-kdevelop.sh
#
# Fix a header with an old include path
[ -f /opt/kde4/include/libkomparediff2/diffsettings.h ] &&
    sed -i 's_include <QtGui/QWidget>_include <QWidget>_' \
    /opt/kde4/include/libkomparediff2/diffsettings.h ||
    ( exit 0 )
#
###################################################

