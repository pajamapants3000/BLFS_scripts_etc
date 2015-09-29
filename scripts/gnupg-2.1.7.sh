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
#libassuan-2.3.0
#libgcrypt-1.6.3
#libksba-1.3.3
#npth-1.2
# End Required
# Begin Recommended
#pin_entry-0.9.5
# End Recommended
# Begin Optional
#curl-7.44.0
#libusb_compat-0.1.5
#openldap-2.4.42
#mta
#texlive-20150521
#gnu_adns
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep gnupg-2.1.7 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.gnupg.org/gcrypt/gnupg/gnupg-2.1.7.tar.bz2
# md5sum:
echo "ebdf92b15b8bcd8579b643c7f41a3238 gnupg-2.1.7.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gnupg-2.1.7.tar.bz2
cd gnupg-2.1.7
sed -e 's|\(GNUPGHOME\)=\$(abs_builddir)|\1=`/bin/pwd`|' \
    -i tests/openpgp/Makefile.in
./configure --prefix=/usr \
            --enable-symcryptrun \
            --docdir=/usr/share/doc/gnupg-2.1.7
make
makeinfo --html --no-split -o doc/gnupg_nochunks.html doc/gnupg.texi
makeinfo --plaintext       -o doc/gnupg.txt           doc/gnupg.texi
#
# with texlive, alt docs:
#make -C doc pdf ps html
# Test:
make check
#
as_root make install
as_root install -v -m755 -d /usr/share/doc/gnupg-2.1.7/html
as_root install -v -m644    doc/gnupg_nochunks.html \
                    /usr/share/doc/gnupg-2.1.7/html/gnupg.html
as_root install -v -m644    doc/*.texi doc/gnupg.txt \
                    /usr/share/doc/gnupg-2.1.7
# create symlinks
for f in gpg gpgv
do
  as_root ln -svf ${f}2.1 /usr/share/man/man1/$f.1
  as_root ln -svf ${f}2   /usr/bin/$f
done
unset f
#
# texlive alt docs
#as_root install -v -m644 doc/gnupg.html/* \
#                 /usr/share/doc/gnupg-2.1.7/html
#as_root install -v -m644 doc/gnupg.{pdf,dvi,ps} \
#                 /usr/share/doc/gnupg-2.1.7
cd ..
as_root rm -rf gnupg-2.1.7
#
# Add to installed list for this computer:
echo "gnupg-2.1.7" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################