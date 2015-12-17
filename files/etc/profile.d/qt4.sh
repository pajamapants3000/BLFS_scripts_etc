#!/bin/bash
#
# Begin /etc/profile.d/qt4.sh
   
QT4DIR=/opt/qt4
[ -d /opt/qt5 ] && export QT5DIR=/opt/qt5
QTDIR=/opt/qt4
   
pathappend /opt/qt4/bin           PATH
pathappend /opt/qt4/lib/pkgconfig PKG_CONFIG_PATH
   
export QT4DIR QTDIR
export PATH PKG_CONFIG_PATH
   
# End /etc/profile.d/qt4.sh

