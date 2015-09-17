#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for startup_notification-0.12
# Time: < 0.1 SBU
# Dependencies
#**************
# Begin Required
#Xorg Libraries
#xcb_util-0.3.9
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
grep startup_notification-0.12 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.freedesktop.org/software/startup-notification/releases/startup-notification-0.12.tar.gz
# md5sum:
echo "2cd77326d4dcaed9a5a23a1232fb38e9 startup-notification-0.12.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
tar -xvf startup-notification-0.12.tar.gz
cd startup-notification-0.12
./configure --prefix=/usr --disable-static
make
as_root make install
as_root install -v -m644 -D doc/startup-notification.txt \
    /usr/share/doc/startup-notification-0.12/startup-notification.txt
cd ..
as_root rm -rf startup-notification-0.12
# Add to list of installed programs on this system
echo "startup_notification-0.12" >> /list-$CHRISTENED"-"$SURNAME
#