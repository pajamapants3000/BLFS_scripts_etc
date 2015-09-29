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
#libatomic_ops-7.4.2
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
grep gc-7.4.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.hboehm.info/gc/gc_source/gc-7.4.2.tar.gz
# md5sum:
echo "12c05fd2811d989341d8c6d81f66af87 gc-7.4.2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gc-7.4.2.tar.gz
cd gc-7.4.2
sed -i 's#pkgdata#doc#' doc/doc.am
autoreconf -fi
./configure --prefix=/usr      \
            --enable-cplusplus \
            --disable-static   \
            --docdir=/usr/share/doc/gc-7.4.2
make
# Test:
make check
#
as_root make install
as_root install -v -m644 doc/gc.man /usr/share/man/man3/gc_malloc.3
as_root ln -sfv gc_malloc.3 /usr/share/man/man3/gc.3 
cd ..
as_root rm -rf gc-7.4.2
#
# Add to installed list for this computer:
echo "gc-7.4.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################