#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for db-6.1.26
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#tcl-8.6.4
#openjdk-1.8.0.45
##java-1.8.0.45
#sharutils-4.15.2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep db-6.1.26 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.oracle.com/berkeley-db/db-6.1.26.tar.gz
# md5sum:
echo "9525aa57a282d49e5d1bf5e48ffa8a56 db-6.1.26.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf db-6.1.26.tar.gz
cd db-6.1.26
cd build_unix
../dist/configure --prefix=/usr      \
                  --enable-compat185 \
                  --enable-dbm       \
                  --disable-static   \
                  --enable-cxx
make
#
as_root make docdir=/usr/share/doc/db-6.1.26 install
as_root chown -v -R root:root                        \
      /usr/bin/db_*                          \
      /usr/include/db{,_185,_cxx}.h          \
      /usr/lib/libdb*.{so,la}                \
      /usr/share/doc/db-6.1.26
cd ../..
as_root rm -rf db-6.1.26
#
# Add to installed list for this computer:
echo "db-6.1.26" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
