#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Updated 07/19/2015
#
# Check for previous installation:
PROCEED="yes"
grep pygtksourceview-2.10.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/pygtksourceview/2.10/pygtksourceview-2.10.1.tar.gz
# Alt. (bz2) download:
#wget http://ftp.gnome.org/pub/gnome/sources/pygtksourceview/2.10/pygtksourceview-2.10.1.tar.bz2
# sha256sum:
echo "2ae9356b0b189e7ebf61e366152aac0a471b17b4ddead5bf747bf4c912a0d698 pygtksourceview-2.10.1.tar.gz" | sha256sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Alt. (bz2) sha256sum:
#echo "b4b47c5aeb67a26141cb03663091dfdf5c15c8a8aae4d69c46a6a943ca4c5974 pygtksourceview-2.10.1.tar.bz2" | sha256sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pygtksourceview-2.10.1.tar.gz
cd pygtksourceview-2.10.1
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf pygtksourceview-2.10.1
# Add to list of installed programs on this system
echo "pygtksourceview-2.10.1" >> /list-$CHRISTENED"-"$SURNAME
#