#
# Begin /etc/profile.d/razorqt.sh
#

RAZORQTDIR=/opt/razorqt
RAZORQT_PREFIX=/opt/razorqt

pathappend /opt/razorqt/bin           PATH
pathappend /opt/razorqt/lib/pkgconfig PKG_CONFIG_PATH
pathappend /opt/razorqt/share         XDG_DATA_DIRS

export RAZORQTDIR
export PATH PKG_CONFIG_PATH XDG_DATA_DIRS

# End /etc/profile.d/razorqt.sh


