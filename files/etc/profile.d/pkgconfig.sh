#!/bin/bash
# Begin /etc/profile.d/pkgconfig.sh

#  PKG_CONFIG_PATH environment variable, and
#+ potentially anything else related to pkgconfig that isn't
#+part of something else.
# For example, qt4.sh, qt5.sh, kde.sh, and others add their own paths
#+to pkgconfig

PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:/usr/lib/pkgconfig

export PKG_CONFIG_PATH

# End /etc/profile.d/pkgconfig.sh
