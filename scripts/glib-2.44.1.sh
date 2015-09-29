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
#libffi-3.2.1
##python-2.7.10
#python-3.4.3
# End Required
# Begin Recommended
#pcre-8.37
#shared_mime_info-1.4
#desktop_file_utils-0.22
# End Recommended
# Begin Optional
#d_bus-1.8.18
#elfutils-0.163
#gtk_doc-1.24
#fam_library
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep glib-2.44.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/glib/2.44/glib-2.44.1.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/glib/2.44/glib-2.44.1.tar.xz
#
# md5sum:
echo "83efba4722a9674b97437d1d99af79db glib-2.44.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf glib-2.44.1.tar.xz
cd glib-2.44.1
grep "python-3" /list-$CHRISTENED"-"$SURNAME > /dev/null && \
./configure --prefix=/usr --with-pcre=system --with-python=python3 ||
./configure --prefix=/usr --with-pcre=system
make
#
as_root make install
cd ..
as_root rm -rf glib-2.44.1
#
# Add to installed list for this computer:
echo "glib-2.44.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
