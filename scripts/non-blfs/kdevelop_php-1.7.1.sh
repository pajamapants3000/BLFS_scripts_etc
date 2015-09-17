#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for kdevelop_php-1.7.1
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
grep "kdevelop_php" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://kde.mirrors.hoobly.com/stable/kdevelop/4.7.1/src/kdevelop-php-1.7.1.tar.xz
# FTP/alt Download:
#wget http://mirror.cc.columbia.edu/pub/software/kde/stable/kdevelop/4.7.1/src/kdevelop-php-1.7.1.tar.xz
# md5sum:
echo "8892cd1cc70c051955909b715a353677 kdevelop-php-1.7.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional documentation download
wget http://kde.mirrors.hoobly.com/stable/kdevelop/4.7.1/src/kdevelop-php-docs-1.7.1.tar.xz
# md5sum:
echo "751cf23bf4ec79f0d5e0515645e33bf5 kdevelop-php-docs-1.7.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf kdevelop-php-1.7.1.tar.xz
cd kdevelop-php-1.7.1
mkdir -v build
cd       build
cmake -DCMAKE_INSTALL_PREFIX=/opt/kdevelop4 ..
#
as_root make install
cd ../..
as_root rm -rf kdevelop-php-1.7.1
#
tar -xvf kdevelop-php-docs-1.7.1.tar.xz
cd kdevelop-php-docs-1.7.1
mkdir -v build
cd       build
cmake -DCMAKE_INSTALL_PREFIX=/opt/kdevelop4 ..
#
as_root make install
cd ../..
as_root rm -rf kdevelop-php-1.7.1
# Add to installed list for this computer:
echo "kdevelop_php-1.7.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
