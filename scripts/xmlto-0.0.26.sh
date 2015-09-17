#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xmlto-0.0.26
#
# Dependencies
#**************
# Begin Required
#docbook_xml-4.5
#docbook_xsl-1.78.1
#libxslt-1.1.28 
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#dblatex
#passivetex
#fop-1.1
#w3m-0.5.3
#links-2.9
#lynx-2.8.8rel.2
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep xmlto-0.0.26 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://fedorahosted.org/releases/x/m/xmlto/xmlto-0.0.26.tar.bz2
# md5sum:
echo "c90a47c774e0963581c1ba57235f64f4 xmlto-0.0.26.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xmlto-0.0.26.tar.bz2
cd xmlto-0.0.26
./configure --prefix=/usr
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf xmlto-0.0.26
#
# Add to installed list for this computer:
echo "xmlto-0.0.26" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################