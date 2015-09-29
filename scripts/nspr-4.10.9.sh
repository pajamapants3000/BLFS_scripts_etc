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
grep nspr-4.10.9 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://ftp.mozilla.org/pub/mozilla.org/nspr/releases/v4.10.9/src/nspr-4.10.9.tar.gz
# FTP/alt Download:
#wget  ftp://ftp.mozilla.org/pub/mozilla.org/nspr/releases/v4.10.9/src/nspr-4.10.9.tar.gz
#
# md5sum:
echo "86769a7fc3b4c30f7fdcb45ab284c452 nspr-4.10.9.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf nspr-4.10.9.tar.gz
cd nspr-4.10.9
cd nspr
sed -ri 's#^(RELEASE_BINS =).*#\1#' pr/src/misc/Makefile.in
sed -i 's#$(LIBRARY) ##' config/rules.mk
./configure --prefix=/usr \
            --with-mozilla \
            --with-pthreads \
            $([ $(uname -m) = x86_64 ] && echo --enable-64bit)
make
#
as_root make install
cd ../..
as_root rm -rf nspr-4.10.9
#
# Add to installed list for this computer:
echo "nspr-4.10.9" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
