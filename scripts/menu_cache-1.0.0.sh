#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for menu_cache-1.0.0
#
# Dependencies
#**************
# Begin Required
#libfm_extra-1.2.3
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
grep menu_cache-1.0.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/lxde/menu-cache-1.0.0.tar.xz
#
# md5sum:
echo "4a8e6c1a86d5e64ec725d850a4abfbad menu-cache-1.0.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf menu-cache-1.0.0.tar.xz
cd menu-cache-1.0.0
./configure --prefix=/usr \
            --disable-static
make
#
as_root make install
cd ..
as_root rm -rf menu-cache-1.0.0
#
# Add to installed list for this computer:
echo "menu_cache-1.0.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
