#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libffi-3.2.1
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#dejagnu-1.5.2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libffi-3.2.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz
# md5sum:
echo "83b89587607e3eb65c70d361f13bab43 libffi-3.2.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libffi-3.2.1.tar.gz
cd libffi-3.2.1
sed -e '/^includesdir/ s/$(libdir).*$/$(includedir)/' \
    -i include/Makefile.in
sed -e '/^includedir/ s/=.*$/=@includedir@/' \
    -e 's/^Cflags: -I${includedir}/Cflags:/' \
    -i libffi.pc.in
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf libffi-3.2.1
#
# Add to installed list for this computer:
echo "libffi-3.2.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################