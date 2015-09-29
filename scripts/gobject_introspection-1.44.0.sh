#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source blfs_profile
#
# Dependencies
#**************
# Begin Required
#glib-2.44.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#cairo-1.14.2
#gtk_doc-1.24
#mako
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gobject_introspection-1.44.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnome.org/pub/gnome/sources/gobject-introspection/1.44/gobject-introspection-1.44.0.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnome.org/pub/gnome/sources/gobject-introspection/1.44/gobject-introspection-1.44.0.tar.xz
#
# md5sum:
echo "7ef8a1db7f74f4193a2397b1587eb913 gobject-introspection-1.44.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gobject-introspection-1.44.0.tar.xz
cd gobject-introspection-1.44.0
./configure --prefix=/usr --disable-static
make -j${PARALLEL}
# Test:
#TEST=check
# Catch expected failing test and log it
if [ $TEST ]; then
    make -j${PARALLEL} -k ${TEST} 2>&1 | \
            tee ../logs/${PROG}-${VERSION}-${DATE}.check; \
    STAT=${PIPESTATUS[0]}; ( exit 0 )
    if (( STAT )); then
        echo "Some tests failed; log in ../$(basename $0)-log"
        echo "Pull up another terminal and check the output"
        echo "Shall we proceed? (say "'"yes"'" or "'"y"'" to proceed)"
        read PROCEED
        [ "$PROCEED" = "y" ] || [ "$PROCEED" = "yes" ]
    fi
fi
#
#
as_root make -j${PARALLEL}  install
cd ..
as_root rm -rf gobject-introspection-1.44.0
#
# Add to installed list for this computer:
echo "gobject_introspection-1.44.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
