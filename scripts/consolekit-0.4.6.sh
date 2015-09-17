#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for consolekit-0.4.6
#
# Dependencies
#**************
# Begin Required
#dbus_glib-0.104
#Xorg Libraries
# End Required
# Begin Recommended
#linux_pam-1.1.8
#polkit-0.112
# End Recommended
# Begin Optional
#xmlto-0.0.26
# End Optional
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
grep consolekit-0.4.6 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://anduin.linuxfromscratch.org/sources/BLFS/svn/c/ConsoleKit-0.4.6.tar.xz
# md5sum:
echo "6aaadf5627d2f7587aa116727e2fc1da ConsoleKit-0.4.6.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf ConsoleKit-0.4.6.tar.xz
cd ConsoleKit-0.4.6
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --enable-udev-acl    \
            --enable-pam-module  \
            --with-systemdsystemunitdir=no
make
#
as_root make install
cd ..
as_root rm -rf ConsoleKit-0.4.6
#
# Add to installed list for this computer:
echo "consolekit-0.4.6" >> /list-$CHRISTENED"-"$SURNAME
#
# Configuration
#***************
as_root tee /etc/pam.d/system-session << "EOF"
# Begin ConsoleKit addition

session   optional    pam_loginuid.so
session   optional    pam_ck_connector.so nox11

# End ConsoleKit addition
EOF
#
as_root tee /usr/lib/ConsoleKit/run-session.d/pam-foreground-compat.ck << "EOF"
#!/bin/sh
TAGDIR=/var/run/console

[ -n "$CK_SESSION_USER_UID" ] || exit 1
[ "$CK_SESSION_IS_LOCAL" = "true" ] || exit 0

TAGFILE="$TAGDIR/`getent passwd $CK_SESSION_USER_UID | cut -f 1 -d:`"

if [ "$1" = "session_added" ]; then
    mkdir -p "$TAGDIR"
    echo "$CK_SESSION_ID" >> "$TAGFILE"
fi

if [ "$1" = "session_removed" ] && [ -e "$TAGFILE" ]; then
    sed -i "\%^$CK_SESSION_ID\$%d" "$TAGFILE"
    [ -s "$TAGFILE" ] || rm -f "$TAGFILE"
fi
EOF
as_root chmod -v 755 /usr/lib/ConsoleKit/run-session.d/pam-foreground-compat.ck
#
# IMPORTANT!!!
#*************
# Warning
#
# If you intend NOT to install polkit, you will need to manually edit the
# ConsoleKit.conf file to lock down the service. Failure to do so may be a
# huge SECURITY HOLE.
###################################################