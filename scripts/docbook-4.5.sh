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
grep "docbook-4.5" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.docbook.org/sgml/4.5/docbook-4.5.zip
#
# md5sum:
echo "07c581f4bbcba6d3aac85360a19f95f7 docbook-4.5.zip" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
mkdir -v docbook-4.5
cd docbook-4.5
unzip ../docbook-4.5.zip
#
sed -i -e '/ISO 8879/d' \
       -e '/gml/d' docbook.cat
#
install -v -d /usr/share/sgml/docbook/sgml-dtd-4.5
chown -R root:root .
install -v docbook.cat /usr/share/sgml/docbook/sgml-dtd-4.5/catalog
cp -v -af *.dtd *.mod *.dcl /usr/share/sgml/docbook/sgml-dtd-4.5
install-catalog --add /etc/sgml/sgml-docbook-dtd-4.5.cat \
        /usr/share/sgml/docbook/sgml-dtd-4.5/catalog
install-catalog --add /etc/sgml/sgml-docbook-dtd-4.5.cat \
        /etc/sgml/sgml-docbook.cat
#
cd ..
as_root rm -rf docbook-4.5
#
cat >> /usr/share/sgml/docbook/sgml-dtd-4.5/catalog << "EOF"
  -- Begin Single Major Version catalog changes --

PUBLIC "-//OASIS//DTD DocBook V4.4//EN" "docbook.dtd"
PUBLIC "-//OASIS//DTD DocBook V4.3//EN" "docbook.dtd"
PUBLIC "-//OASIS//DTD DocBook V4.2//EN" "docbook.dtd"
PUBLIC "-//OASIS//DTD DocBook V4.1//EN" "docbook.dtd"
PUBLIC "-//OASIS//DTD DocBook V4.0//EN" "docbook.dtd"

  -- End Single Major Version catalog changes --
EOF
# Add to installed list for this computer:
echo "docbook-3.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################


