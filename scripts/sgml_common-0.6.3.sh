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
grep sgml_common-0.6.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://sources.redhat.com/pub/docbook-tools/new-trials/SOURCES/sgml-common-0.6.3.tgz
# md5sum:
echo "103c9828f24820df86e55e7862e28974 sgml-common-0.6.3.tgz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/sgml-common-0.6.3-manpage-1.patch
tar -xvf sgml-common-0.6.3.tgz
cd sgml-common-0.6.3
patch -Np1 -i ../sgml-common-0.6.3-manpage-1.patch
autoreconf -f -i
./configure --prefix=/usr --sysconfdir=/etc
make
#
as_root make docdir=/usr/share/doc install
as_root install-catalog --add /etc/sgml/sgml-ent.cat \
    /usr/share/sgml/sgml-iso-entities-8879.1986/catalog
as_root install-catalog --add /etc/sgml/sgml-docbook.cat \
    /etc/sgml/sgml-ent.cat
cd ..
as_root rm -rf sgml-common-0.6.3
#
# Add to installed list for this computer:
echo "sgml_common-0.6.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# TO UPGRADE - as root:
#install-catalog --remove /etc/sgml/sgml-ent.cat \
#    /usr/share/sgml/sgml-iso-entities-8879.1986/catalog
#install-catalog --remove /etc/sgml/sgml-docbook.cat \
#    /etc/sgml/sgml-ent.cat
###################################################