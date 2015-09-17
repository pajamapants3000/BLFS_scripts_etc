#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gnome_python_extras-2.25.3
# Updated 07/19/2015
#
# Dependencies
#**************
# Begin Required
#python-3.4.3
#gtk+-3.16.6
#python-2.7.10
#gtk+-2.24.28
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
REINSTALL=0
grep gnome_python_extras-2.25.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/GNOME/sources/gnome-python-extras/2.25/gnome-python-extras-2.25.3.tar.gz
# md5sum:
echo "375782d50d42cb1704533ffc42acc5f9 gnome-python-extras-2.25.3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gnome-python-extras-2.25.3.tar.gz
cd gnome-python-extras-2.25.3
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf gnome-python-extras-2.25.3
#
# Add to installed list for this computer:
echo "gnome_python_extras-2.25.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################