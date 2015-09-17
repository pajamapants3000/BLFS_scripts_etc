#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for pcre-8.37
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#valgrind-3.10.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep pcre-8.37 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.tar.bz2
# md5sum:
echo "ed91be292cb01d21bc7e526816c26981 pcre-8.37.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pcre-8.37.tar.bz2
cd pcre-8.37
./configure --prefix=/usr                     \
            --docdir=/usr/share/doc/pcre-8.37 \
            --enable-unicode-properties       \
            --enable-pcre16                   \
            --enable-pcre32                   \
            --enable-pcregrep-libz            \
            --enable-pcregrep-libbz2          \
            --enable-pcretest-libreadline     \
            --disable-static
make
# Test:
make check
#
as_root make install
as_root mv -v /usr/lib/libpcre.so.* /lib
as_root ln -sfv ../../lib/$(readlink /usr/lib/libpcre.so) /usr/lib/libpcre.so
cd ..
as_root rm -rf pcre-8.37
#
# Add to installed list for this computer:
echo "pcre-8.37" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
