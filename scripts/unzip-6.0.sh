#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Check for previous installation:
PROCEED="yes"
grep unzip-6.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/infozip/unzip60.tar.gz
# md5sum:
echo "62b490407489521db863b523a7f86375 unzip60.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
tar -xvf unzip60.tar.gz
cd unzip60
case `uname -m` in
  i?86)
    sed -i -e 's/DASM_CRC"/DASM_CRC -DNO_LCHMOD"/' unix/Makefile
    make -f unix/Makefile linux
    ;;
  *)
    sed -i -e 's/CFLAGS="-O -Wall/& -DNO_LCHMOD/' unix/Makefile
    make -f unix/Makefile linux_noasm
    ;;
esac
# To test results, issue...
make check
as_root make prefix=/usr MANDIR=/usr/share/man/man1 install
cd ..
as_root rm -rf unzip60
# Add to list of installed programs on this system
echo "unzip-6.0" >> /list-$CHRISTENED"-"$SURNAME
#