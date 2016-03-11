#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source ${HOME}/.blfs_profile
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#db-6.1.26
#doxygen-1.8.10
#graphviz-2.38.0
#openssl-1.0.2d
#tk-8.6.4
#libyaml
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "ruby-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.3.tar.xz
# md5sum:
echo "2a8bc1f46aba8938add70f742e8af1ff ruby-2.2.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf ruby-2.2.3.tar.xz
cd ruby-2.2.3
./configure --prefix=/usr   \
            --enable-shared \
            --docdir=/usr/share/doc/ruby-2.2.3
make
make capi
# Test:
make test
#
as_root make install
cd ..
as_root rm -rf ruby-2.2.3
#
# Add to installed list for this computer:
echo "ruby-2.2.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################