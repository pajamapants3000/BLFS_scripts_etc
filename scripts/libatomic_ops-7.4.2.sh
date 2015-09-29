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
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libatomic_ops-7.4.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.ivmaisoft.com/_bin/atomic_ops//libatomic_ops-7.4.2.tar.gz
# md5sum:
echo "1d6538604b314d2fccdf86915e5c0857 libatomic_ops-7.4.2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libatomic_ops-7.4.2.tar.gz
cd libatomic_ops-7.4.2
sed -i 's#pkgdata#doc#' doc/Makefile.am
autoreconf -fi
./configure --prefix=/usr    \
            --enable-shared  \
            --disable-static \
            --docdir=/usr/share/doc/libatomic_ops-7.4.2
make
# Test:
LD_LIBRARY_PATH=../src/.libs make check
#
as_root make install
as_root mv -v   /usr/share/libatomic_ops/* \
        /usr/share/doc/libatomic_ops-7.4.2
as_root rm -vrf /usr/share/libatomic_ops
cd ..
as_root rm -rf libatomic_ops-7.4.2
#
# Add to installed list for this computer:
echo "libatomic_ops-7.4.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################