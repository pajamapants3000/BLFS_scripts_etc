#!/bin/bash
#
# Begin /etc/profile.d/qt5.sh

QT5DIR=/opt/qt5
[ -d /opt/qt4 ] && export QT4DIR=/opt/qt4
QTDIR=/opt/qt5

pathappend /opt/qt5/bin			    PATH
pathappend /opt/qt5/lib/pkgconfig 	PKG_CONFIG_PATH

export QT5DIR QTDIR
export PATH PKG_CONFIG_PATH

# Begin /etc/profile.d/qt5.sh
# ** Qt5 changes for KF5
#

pathappend /opt/qt5/plugins             QT_PLUGIN_PATH
pathappend /opt/qt5/qml                 QML_IMPORT_PATH
pathappend /opt/qt5/qml                 QML2_IMPORT_PATH

export QT_PLUGIN_PATH QML_IMPORT_PATH QML2_IMPORT_PATH

# End /etc/profile.d/qt5.sh

