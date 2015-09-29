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
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gobject_introspection-1.44.0
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "babl-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.gimp.org/pub/babl/0.1/babl-0.1.12.tar.bz2
# md5sum:
echo "50c8d12cdf5b3991590fa6cba16218a0 babl-0.1.12.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf babl-0.1.12.tar.bz2
cd babl-0.1.12
./configure --prefix=/usr --disable-docs
make
# Test:
make check
#
as_root make install
as_root install -v -m755 -d /usr/share/gtk-doc/html/babl/graphics
as_root install -v -m644 docs/*.{css,html} /usr/share/gtk-doc/html/babl
as_root install -v -m644 docs/graphics/*.{html,png,svg} /usr/share/gtk-doc/html/babl/graphics
cd ..
as_root rm -rf babl-0.1.12
#
# Add to installed list for this computer:
echo "babl-0.1.12" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#