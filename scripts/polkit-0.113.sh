#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for polkit-0.113
#
# Dependencies
#**************
# Begin Required
#glib-2.44.1
#js-17.0.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gobject-introspection-1.44.0
#docbook_xml-4.5
#docbook_xsl-1.78.1
#gtk_doc-1.24
#libxslt-1.1.28
#linux_pam-1.2.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep polkit-0.113 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.freedesktop.org/software/polkit/releases/polkit-0.113.tar.gz
# md5sum:
echo "4b77776c9e4f897dcfe03b2c34198edf polkit-0.113.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
if ! (cat /etc/group | grep polkitd > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -fg 27 polkitd
    as_root useradd -c "PolicyKit_Daemon_Owner" -d /etc/polkit-1 -u 27 \
        -g polkitd -s /bin/false polkitd
    pathremove /usr/sbin
fi
#
tar -xvf polkit-0.113.tar.gz
cd polkit-0.113
grep linux_pam /list-$CHRISTENED"-"$SURNAME > /dev/null && \
./configure --prefix=/usr                \
            --sysconfdir=/etc            \
            --localstatedir=/var         \
            --disable-static             \
            --enable-libsystemd-login=no || \
./configure --prefix=/usr                \
            --sysconfdir=/etc            \
            --localstatedir=/var         \
            --disable-static             \
            --enable-libsystemd-login=no \
            --with-authfw=shadow
make
# Test (system dbus session; ignore consolekit db missing warning):
if (grep dbus /list-$CHRISTENED"-"$SURNAME > /dev/null); then
    make check
fi
#
as_root make install
#
as_root tee /etc/pam.d/polkit-1 << "EOF"
# Begin /etc/pam.d/polkit-1

auth     include        system-auth
account  include        system-account
password include        system-password
session  include        system-session

# End /etc/pam.d/polkit-1
EOF
cd ..
as_root rm -rf polkit-0.113
#
# Add to installed list for this computer:
echo "polkit-0.113" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
