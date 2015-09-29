#!/bin/bash -e
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
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
#unzip-6.0
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
grep "docbook-3.1" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.docbook.org/sgml/3.1/docbk31.zip
# FTP/alt Download:
#wget ftp://ftp.kde.org/pub/kde/devel/docbook/SOURCES/docbk31.zip
#
# md5sum:
echo "432749c0c806dbae81c8bcb70da3b5d3 docbk31.zip" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
mkdir -v docbk31
cd docbk31
unzip ../docbk31.zip
#
sed -i -e '/ISO 8879/d' \
       -e 's|DTDDECL "-//OASIS//DTD DocBook V3.1//EN"|SGMLDECL|g' \
       docbook.cat
#
install -v -d -m755 /usr/share/sgml/docbook/sgml-dtd-3.1
chown -R root:root .
install -v docbook.cat /usr/share/sgml/docbook/sgml-dtd-3.1/catalog
cp -v -af *.dtd *.mod *.dcl /usr/share/sgml/docbook/sgml-dtd-3.1
install-catalog --add /etc/sgml/sgml-docbook-dtd-3.1.cat \
        /usr/share/sgml/docbook/sgml-dtd-3.1/catalog
install-catalog --add /etc/sgml/sgml-docbook-dtd-3.1.cat \
        /etc/sgml/sgml-docbook.cat
#
cd ..
as_root rm -rf docbk31
#
cat >> /usr/share/sgml/docbook/sgml-dtd-3.1/catalog << "EOF"
  -- Begin Single Major Version catalog changes --

PUBLIC "-//Davenport//DTD DocBook V3.0//EN" "docbook.dtd"

  -- End Single Major Version catalog changes --
EOF
# Add to installed list for this computer:
echo "docbook-3.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

