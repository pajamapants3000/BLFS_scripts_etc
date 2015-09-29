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
#unzip-6.0
# End Required
# Begin Recommended
#libjpeg_turbo-1.4.1
# End Recommended
# Begin Optional
#freeglut-3.0.0
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep jasper-1.900.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.ece.uvic.ca/~mdadams/jasper/software/jasper-1.900.1.zip
# md5sum:
echo "a342b2b4495b3e1394e161eb5d85d754 jasper-1.900.1.zip" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/jasper-1.900.1-security_fixes-2.patch
unzip jasper-1.900.1.zip
cd jasper-1.900.1
patch -Np1 -i ../jasper-1.900.1-security_fixes-2.patch
./configure --prefix=/usr    \
            --enable-shared  \
            --disable-static \
            --mandir=/usr/share/man
make
#
as_root make install
# Install docs (opt)
as_root install -v -m755 -d /usr/share/doc/jasper-1.900.1
as_root install -v -m644 doc/*.pdf /usr/share/doc/jasper-1.900.1
cd ..
as_root rm -rf jasper-1.900.1
#
# Add to installed list for this computer:
echo "jasper-1.900.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################