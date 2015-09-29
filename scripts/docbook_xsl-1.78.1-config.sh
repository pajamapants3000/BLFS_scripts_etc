#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
#CANNOT SOURCE blfs_profile, but will be passed from installer anyway.
#
# Dependencies
#**************
# Begin Required
#docbook_xsl-1.78.1
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
grep docbook_xsl-1.78.1-config /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
if [ ! -d /etc/xml ]; then install -v -m755 -d /etc/xml; fi
if [ ! -f /etc/xml/catalog ]; then
    xmlcatalog --noout --create /etc/xml/catalog
fi
xmlcatalog --noout --add "rewriteSystem" \
           "http://docbook.sourceforge.net/release/xsl/1.78.1" \
           "/usr/share/xml/docbook/xsl-stylesheets-1.78.1" \
    /etc/xml/catalog
xmlcatalog --noout --add "rewriteURI" \
           "http://docbook.sourceforge.net/release/xsl/1.78.1" \
           "/usr/share/xml/docbook/xsl-stylesheets-1.78.1" \
    /etc/xml/catalog
xmlcatalog --noout --add "rewriteSystem" \
           "http://docbook.sourceforge.net/release/xsl/current" \
           "/usr/share/xml/docbook/xsl-stylesheets-1.78.1" \
    /etc/xml/catalog
xmlcatalog --noout --add "rewriteURI" \
           "http://docbook.sourceforge.net/release/xsl/current" \
           "/usr/share/xml/docbook/xsl-stylesheets-1.78.1" \
    /etc/xml/catalog
# To install an additional specific <version>
#xmlcatalog --noout --add "rewriteSystem" \
#           "http://docbook.sourceforge.net/release/xsl/<version>" \
#           "/usr/share/xml/docbook/xsl-stylesheets-<version>" \
#    /etc/xml/catalog
#xmlcatalog --noout --add "rewriteURI" \
#           "http://docbook.sourceforge.net/release/xsl/<version>" \
#           "/usr/share/xml/docbook/xsl-stylesheets-<version>" \
#    /etc/xml/catalog
#
# Add to installed list for this computer:
echo "docbook_xsl-1.78.1-config" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################