#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for parted-3.2
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#lvm2-2.02.125
# End Recommended
# Begin Optional
#pth-2.0.7
#texlive-20150521
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep parted-3.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://ftp.gnu.org/gnu/parted/parted-3.2.tar.xz
# md5sum:
echo "0247b6a7b314f8edeb618159fa95f9cb parted-3.2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/parted-3.2-devmapper-1.patch
tar -xvf parted-3.2.tar.gz
cd parted-3.2
patch -Np1 -i ../parted-3.2-devmapper-1.patch
./configure --prefix=/usr --disable-static
make
make -C doc html
makeinfo --html      -o doc/html       doc/parted.texi
makeinfo --plaintext -o doc/parted.txt doc/parted.texi
#
# with texlive - create PDF and PS docs
texi2pdf             -o doc/parted.pdf doc/parted.texi
texi2dvi             -o doc/parted.dvi doc/parted.texi
dvips                -o doc/parted.ps  doc/parted.dvi
# Test (many are skipped if not run as root):
sed -i '/t0251-gpt-unicode.sh/d' tests/Makefile
make check
#
as_root make install
as_root install -v -m755 -d /usr/share/doc/parted-3.2/html
as_root install -v -m644    doc/html/* \
                    /usr/share/doc/parted-3.2/html
as_root install -v -m644    doc/{FAT,API,parted.{txt,html}} \
                    /usr/share/doc/parted-3.2
#
# Install texlive docs
as_root install -v -m644 doc/FAT doc/API doc/parted.{pdf,ps,dvi} \
                    /usr/share/doc/parted-3.2
cd ..
as_root rm -rf parted-3.2
#
# Add to installed list for this computer:
echo "parted-3.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################