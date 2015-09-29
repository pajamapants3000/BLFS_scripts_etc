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
#glib-2.42.1
#iso_codes-3.5
#libxml2-2.9.2
#Xorg Libraries
# End Required
# Begin Recommended
#gobject-introspection-1.42.0
# End Recommended
# Begin Optional
#gtk_doc-1.21
#vala-0.26.2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libxklavier-5.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://pkgs.fedoraproject.org/repo/pkgs/libxklavier/libxklavier-5.4.tar.bz2/13af74dcb6011ecedf1e3ed122bd31fa/libxklavier-5.4.tar.bz2
# md5sum:
echo "13af74dcb6011ecedf1e3ed122bd31fa libxklavier-5.4.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libxklavier-5.4.tar.bz2
cd libxklavier-5.4
./configure --prefix=/usr --disable-static &&
make
#
as_root make install
cd ..
as_root rm -rf libxklavier-5.4
#
# Add to installed list for this computer:
echo "libxklavier-5.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

