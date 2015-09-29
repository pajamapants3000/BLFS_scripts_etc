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
#expect-5.45
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#docbook_utils-0.6.14
#docbook2x
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep dejagnu-1.5.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://ftp.gnu.org/pub/gnu/dejagnu/dejagnu-1.5.3.tar.gz
# FTP/alt Download:
#wget ftp://ftp.gnu.org/pub/gnu/dejagnu/dejagnu-1.5.3.tar.gz
#
# md5sum:
echo "5bda2cdb1af51a80aecce58d6e42bd2f dejagnu-1.5.3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf dejagnu-1.5.3.tar.gz
cd dejagnu-1.5.3
./configure --prefix=/usr
makeinfo --html --no-split -o doc/dejagnu.html doc/dejagnu.texi
makeinfo --plaintext       -o doc/dejagnu.txt  doc/dejagnu.texi
# Test:
make check
#
as_root make install
as_root install -v -dm755   /usr/share/doc/dejagnu-1.5.3
as_root install -v -m644    doc/dejagnu.{html,txt} \
                    /usr/share/doc/dejagnu-1.5.
cd ..
as_root rm -rf dejagnu-1.5.3
#
# Add to installed list for this computer:
echo "dejagnu-1.5.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################