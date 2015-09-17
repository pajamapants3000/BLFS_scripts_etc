#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for harfbuzz-1.0.2
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#glib-2.44.1
#icu-55.1
#freeType-2.6
# End Recommended
# Begin Optional
#cairo-1.14.2
#gobject_introspection-1.44.0
#gtk_doc-1.24
#graphite2-1.3.0
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep harfbuzz-1.0.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-1.0.2.tar.bz2
# md5sum:
echo "e74f644045fe42c38a2641fc1e82a800 harfbuzz-1.0.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf harfbuzz-1.0.2.tar.bz2
cd harfbuzz-1.0.2
./configure --prefix=/usr --with-gobject
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf harfbuzz-1.0.2
#
# Add to installed list for this computer:
echo "harfbuzz-1.0.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################