#
# Begin /etc/profile.d/cdrtools.sh

pathappend      /opt/schily/bin         PATH
pathappend      /opt/schily/share/man   MANPATH
pathprepend     /opt/schily/share       XDG_DATA_DIRS 

if [ $EUID -eq 0 ] ; then
  pathappend /opt/schily/sbin
fi

# End /etc/profile.d/kdevelop.sh


