#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for docbook_dsssl-1.79-tooltest
#
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
#
# Dependencies
#**************
# Begin Required
#sgml_common-0.6.3
#docbook-3.1
#docbook-4.5
#opensp-1.5.2
#openjade-1.3.2
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
grep docbook_dsssl-1.79-tooltest /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/docbook/docbook-dsssl-1.79.tar.bz2
# FTP/alt Download:
#wget ftp://mirror.ovh.net/gentoo-distfiles/distfiles/docbook-dsssl-1.79.tar.bz2
#
# md5sum:
echo "bc192d23266b9a664ca0aba4a7794c7c docbook-dsssl-1.79.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional Download - Documentation and test data:
wget http://downloads.sourceforge.net/docbook/docbook-dsssl-doc-1.79.tar.bz2
# md5sum:
echo "9a7b809a21ab7d2749bb328334c380f2 docbook-dsssl-doc-1.79.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf docbook-dsssl-1.79.tar.gz
cd docbook-dsssl-1.79
#
# Optional doc downloaded...
tar -xf ../docbook-dsssl-doc-1.79.tar.bz2 --strip-components=1
#
install -v -m755 bin/collateindex.pl /usr/bin
install -v -m644 bin/collateindex.pl.1 /usr/share/man/man1
install -v -d -m755 /usr/share/sgml/docbook/dsssl-stylesheets-1.79
cp -v -R * /usr/share/sgml/docbook/dsssl-stylesheets-1.79
install-catalog --add /etc/sgml/dsssl-docbook-stylesheets.cat \
    /usr/share/sgml/docbook/dsssl-stylesheets-1.79/catalog
install-catalog --add /etc/sgml/dsssl-docbook-stylesheets.cat \
    /usr/share/sgml/docbook/dsssl-stylesheets-1.79/common/catalog
install-catalog --add /etc/sgml/sgml-docbook.cat              \
    /etc/sgml/dsssl-docbook-stylesheets.cat
#
cd /usr/share/sgml/docbook/dsssl-stylesheets-1.79/doc/testdata
openjade -t rtf -d jtest.dsl jtest.sgm
onsgmls -sv test.sgm
openjade -t rtf \
    -d /usr/share/sgml/docbook/dsssl-stylesheets-1.79/print/docbook.dsl \
    test.sgm
openjade -t sgml \
    -d /usr/share/sgml/docbook/dsssl-stylesheets-1.79/html/docbook.dsl \
    test.sgm
rm jtest.rtf test.rtf c1.htm
#
cd ..
as_root rm -rf docbook-dsssl-1.79
#
# Add to installed list for this computer:
echo "docbook_dsssl-1.79-tooltest" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################