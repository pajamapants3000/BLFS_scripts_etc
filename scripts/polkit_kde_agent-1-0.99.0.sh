#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for polkit_kde_agent-1-0.99.0
#
# Dependencies
#**************
# Begin Required
#polkit-qt-0.112.0
#kdelibs-4.14.10
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
grep polkit_kde_agent-1-0.99.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/apps/KDE4.x/admin/polkit-kde-agent-1-0.99.0.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/stable/apps/KDE4.x/admin/polkit-kde-agent-1-0.99.0.tar.bz2
#
# md5sum:
echo "a02d3fddc6270a88bceaf3ba604c92f8 polkit-kde-agent-1-0.99.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/polkit-kde-agent-1-0.99.0-remember_password-1.patch
tar -xvf polkit-kde-agent-1-0.99.0.tar.bz2
cd polkit-kde-agent-1-0.99.0
patch -Np1 -i ../polkit-kde-agent-1-0.99.0-remember_password-1.patch
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=$KDE_PREFIX -Wno-dev ..
make
#
as_root make install
cd ../..
as_root rm -rf polkit-kde-agent-1-0.99.0
#
# Add to installed list for this computer:
echo "polkit_kde_agent-1-0.99.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################