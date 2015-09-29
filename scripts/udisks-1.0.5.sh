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
#dbus_glib-0.104
#libatasmart-0.19
#libgudev-230
#lvm2-2.02.125
#parted-3.2
#polkit-0.113
#sg3_utils-1.41
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gtk_doc-1.24
#libxslt-1.1.28
#sudo-1.8.14p3
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep udisks-1.0.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://hal.freedesktop.org/releases/udisks-1.0.5.tar.gz
# md5sum:
echo "70d48dcfe523a74cd7c7fbbc2847fcdd udisks-1.0.5.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf udisks-1.0.5.tar.gz
cd udisks-1.0.5
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var
make
# Test:
make check
#
as_root make profiledir=/etc/bash_completion.d install
cd ..
as_root rm -rf udisks-1.0.5
#
# Add to installed list for this computer:
echo "udisks-1.0.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################