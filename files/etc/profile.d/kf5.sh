#!/bin/bash
#
# Begin /etc/profile.d/kf5.sh
#

KF5_PREFIX=/opt/kf5

pathappend /opt/kf5                     KDEDIRS
pathappend /opt/kf5/bin             	PATH
pathappend /opt/kf5/lib/pkgconfig   	PKG_CONFIG_PATH

pathappend /etc/xdg			            XDG_CONFIG_DIRS
pathappend /opt/kf5/etc/xdg         	XDG_CONFIG_DIRS
pathappend /usr/share                  	XDG_DATA_DIRS
pathappend /opt/kf5/share           	XDG_DATA_DIRS

pathappend /usr/lib/qt5/plugins        	QT_PLUGIN_PATH
pathappend /opt/kf5/lib/plugins     	QT_PLUGIN_PATH

pathappend /usr/lib/qt5/qml            	QML_IMPORT_PATH
pathappend /opt/kf5/lib/qml         	QML_IMPORT_PATH

pathappend /usr/lib/qt5/qml            	QML2_IMPORT_PATH
pathappend /opt/kf5/lib/qml         	QML2_IMPORT_PATH

pathappend /opt/kf5/lib/python2.7/site-packages PYTHONPATH
pathappend /opt/kf5/lib/python3.4/site-packages PYTHONPATH

export KF5_PREFIX
export PATH KDEDIRS XDG_DATA_DIRS XDG_CONFIG_DIRS
export QT_PLUGIN_PATH QML_IMPORT_PATH QML2_IMPORT_PATH
export PYTHONPATH

# End /etc/profile.d/kf5.sh

