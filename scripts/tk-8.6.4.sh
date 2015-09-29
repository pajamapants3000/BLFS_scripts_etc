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
#tcl-8.6.4
#Xorg Libraries
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
grep tk-8.6.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/tcl/tk8.6.4-src.tar.gz
# md5sum:
echo "261754d7dc2a582f00e35547777e1fea tk8.6.4-src.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf tk8.6.4-src.tar.gz
cd tk8.6.4
cd unix
./configure --prefix=/usr \
            --mandir=/usr/share/man \
            $([ $(uname -m) = x86_64 ] && echo --enable-64bit)
make
sed -e "s@^\(TK_SRC_DIR='\).*@\1/usr/include'@" \
    -e "/TK_B/s@='\(-L\)\?.*unix@='\1/usr/lib@" \
    -i tkConfig.sh
#
as_root make install
as_root make install-private-headers
as_root ln -v -sf wish8.6 /usr/bin/wish
as_root chmod -v 755 /usr/lib/libtk8.6.so
cd ../..
as_root rm -rf tk8.6.4
#
# Add to installed list for this computer:
echo "tk-8.6.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
