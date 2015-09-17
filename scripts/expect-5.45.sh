#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for expect5.45
#
# Dependencies
#**************
# Begin Required
#tcl-8.6.4
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#tk-8.6.4
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep expect5.45 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://prdownloads.sourceforge.net/expect/expect5.45.tar.gz
# md5sum:
echo "44e1a4f4c877e9ddc5a542dfa7ecc92b expect5.45.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf expect5.45.tar.gz
cd expect5.45
./configure --prefix=/usr           \
            --with-tcl=/usr/lib     \
            --enable-shared         \
            --mandir=/usr/share/man \
            --with-tclinclude=/usr/include
make
# Test:
make test
#
as_root make install
as_root ln -svf expect5.45/libexpect5.45.so /usr/lib
cd ..
as_root rm -rf expect5.45
#
# Add to installed list for this computer:
echo "expect5.45" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################