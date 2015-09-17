#!/bin/bash -ev
# Installation script for qpdfview-0.4.15
# Updated 07/19/2015
#
# Dependencies
#**************
# Begin Required
#qt-4.8.7
#or
#qt-5.5.0
# End Required
# Begin Recommended
#librsvg-2.40.10
#poppler-0.35.0-qt
#libspectre-0.2.7
#djvulibre-3.5.27
#sqlite-3.8.11.1
#dbus-1.10.0
# End Recommended
# Begin Optional
#cups-2.0.4
#fitz
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep qpdfview-0.4.15 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://launchpad.net/qpdfview/trunk/0.4.15/+download/qpdfview-0.4.15.tar.gz
# md5sum:
echo "d7e4066f9062a00380e9aa78c12a882e qpdfview-0.4.15.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
source blfs_profile
#
tar -xvf qpdfview-0.4.15.tar.gz
cd qpdfview-0.4.15
qmake CONFIG+="${QPDF_CONFIG}" qpdfview.pro
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf qpdfview-0.4.15
#
# Add to installed list for this computer:
echo "qpdfview-0.4.15" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
