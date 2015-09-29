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
#chrpath-0.16
#qt-5.5.0
#qt-4.8.7
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#pyqt-5.5
#pyqt-4.11.4
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "qscintilla_gpl-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/pyqt/QScintilla-gpl-2.9.tar.gz
# md5sum:
echo "24659879edf9786f41a9b9268ce3c817 QScintilla-gpl-2.9.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch for qt5
wget http://www.linuxfromscratch.org/patches/blfs/svn/QScintilla-gpl-2.9-fixes-1.patch
#
# Source qt5 in favor of qt4?
source setqt5
#
tar -xvf QScintilla-gpl-2.9.tar.gz
cd QScintilla-gpl-2.9
patch -Np1 -i ../QScintilla-gpl-2.9-fixes-1.patch
cd Qt4Qt5
qmake qscintilla.pro
make
#
as_root make install
# To install docs
as_root install -v -m755 -d $QT5DIR/share/doc/QScintilla-2.9 &&
as_root install -v -m644    ../doc/html-Qt4Qt5/* \
#        $QT5DIR/share/doc/QScintilla-2.9
#
cd ../..
as_root rm -rf QScintilla-gpl-2.9
#
# Add to installed list for this computer:
echo "qscintilla_gpl-2.9" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#

