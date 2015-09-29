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
#exo-0.10.6
#garcon-0.5.0
#libwnck-2.30.7
#libxfce4ui-4.12.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gtk_doc-1.24
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xfce4_panel-4.12.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://archive.xfce.org/src/xfce/xfce4-panel/4.12/xfce4-panel-4.12.0.tar.bz2
# md5sum:
echo "5a333af704e386c90ad829b6baf1a758 xfce4-panel-4.12.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xfce4-panel-4.12.0.tar.bz2
cd xfce4-panel-4.12.0
./configure --prefix=/usr --sysconfdir=/etc --enable-gtk3
make
#
as_root make install
cd ..
as_root rm -rf xfce4-panel-4.12.0
#
# Add to installed list for this computer:
echo "xfce4_panel-4.12.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################