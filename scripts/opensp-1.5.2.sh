#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for opensp-1.5.2
#
# Dependencies
#**************
# Begin Required
#sgml_common-0.6.3
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#xmlto-0.0.26
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep opensp-1.5.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/openjade/OpenSP-1.5.2.tar.gz
# md5sum:
echo "670b223c5d12cee40c9137be86b6c39b OpenSP-1.5.2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf OpenSP-1.5.2.tar.gz
cd OpenSP-1.5.2
sed -i 's/32,/253,/' lib/Syntax.cxx
sed -i 's/LITLEN          240 /LITLEN          8092/' \
    unicode/{gensyntax.pl,unicode.syn}
./configure --prefix=/usr                              \
            --disable-static                           \
            --disable-doc-build                        \
            --enable-default-catalog=/etc/sgml/catalog \
            --enable-http                              \
            --enable-default-search-path=/usr/share/sgml
make pkgdatadir=/usr/share/sgml/OpenSP-1.5.2
# Test (as many as nine tests may fail):
#make check
#
as_root make pkgdatadir=/usr/share/sgml/OpenSP-1.5.2 \
     docdir=/usr/share/doc/OpenSP-1.5.2      \
     install
as_root ln -v -sf onsgmls   /usr/bin/nsgmls
as_root ln -v -sf osgmlnorm /usr/bin/sgmlnorm
as_root ln -v -sf ospam     /usr/bin/spam
as_root ln -v -sf ospcat    /usr/bin/spcat
as_root ln -v -sf ospent    /usr/bin/spent
as_root ln -v -sf osx       /usr/bin/sx
as_root ln -v -sf osx       /usr/bin/sgml2xml
as_root ln -v -sf libosp.so /usr/lib/libsp.so
cd ..
as_root rm -rf OpenSP-1.5.2
#
# Add to installed list for this computer:
echo "opensp-1.5.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
