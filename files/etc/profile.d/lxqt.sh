#
# Begin /etc/profile.d/lxqt.sh
#

LXQT_PREFIX=/opt/lxqt
LXQTDIR=/opt/lxqt

pathappend /opt/lxqt/bin           PATH
pathappend /opt/lxqt/share/man/    MANPATH
pathappend /opt/lxqt/lib/pkgconfig PKG_CONFIG_PATH

export LXQT_PREFIX LXQTDIR
export PATH MANPATH PKG_CONFIG_PATH

# End /etc/profile.d/lxqt.sh

