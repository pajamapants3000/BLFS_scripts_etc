#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xfce4_session-4.12.1
#
# Dependencies
#**************
# Begin Required
#libwnck-2.30.7
#libxfce4ui-4.12.1
#which-2.21
#xorg_applications
# End Required
# Begin Required Runtime
#xfdesktop-4.12.3
# End Required Runtime
# Begin Recommended
#desktop_file_utils-0.22
#shared_mime_info-1.4
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
REINSTALL=0
grep xfce4_session-4.12.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/xfce4-session/4.12/xfce4-session-4.12.1.tar.bz2
# md5sum:
echo "f4921fb2e606e74643daf1212263076c xfce4-session-4.12.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xfce4-session-4.12.1.tar.gz
cd xfce4-session-4.12.1
./configure --prefix=/usr \
            --sysconfdir=/etc \
            --disable-legacy-sm
make
#
as_root make install
cd ..
as_root rm -rf xfce4-session-4.12.1
#
# Add to installed list for this computer:
echo "xfce4_session-4.12.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################