#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for sqlite-3.8.11.1
#
source blfs_profile
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#unzip-6.0
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "sqlite-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sqlite.org/2015/sqlite-autoconf-3081101.tar.gz
# md5sum:
echo "298c8d6af7ca314f68de92bc7a356cbe sqlite-autoconf-3081101.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# optional doc download:
wget http://sqlite.org/2015/sqlite-doc-3081101.zip
# md5sum:
echo "29fc9f4d2346187b11c09f867d69b427 sqlite-doc-3081101.zip" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf sqlite-autoconf-3081101.tar.gz
pushd sqlite-autoconf-3081101
unzip -q ../sqlite-doc-3081101.zip
./configure --prefix=/usr --disable-static        \
            CFLAGS="-g -O2 -DSQLITE_ENABLE_FTS3=1 \
            -DSQLITE_ENABLE_COLUMN_METADATA=1     \
            -DSQLITE_ENABLE_UNLOCK_NOTIFY=1       \
            -DSQLITE_SECURE_DELETE=1"
make -j1
#
as_root make install
as_root install -v -m755 -d /usr/share/doc/sqlite-3.8.11.1
as_root cp -v -R sqlite-doc-3081101/* /usr/share/doc/sqlite-3.8.11.1
popd
as_root rm -rf sqlite-autoconf-3081101
#
# Add to installed list for this computer:
echo "sqlite-3.8.11.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
