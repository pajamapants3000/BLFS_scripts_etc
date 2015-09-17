#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for docbook_xsl-1.78.1
#
# Dependencies
#**************
# Begin Required
#libxml2-2.9.2
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#ruby-2.2.0
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep docbook_xsl-1.78.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/docbook/docbook-xsl-1.78.1.tar.bz2
# Download was having issues; here is a backup:
#wget http://anduin.linuxfromscratch.org/sources/BLFS/svn/d/docbook-xsl-1.78.1.tar.bz2
# md5sum:
echo "6dd0f89131cc35bf4f2ed105a1c17771 docbook-xsl-1.78.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Download:
wget http://downloads.sourceforge.net/docbook/docbook-xsl-doc-1.78.1.tar.bz2
# Download was having issues; here is a backup:
#wget http://anduin.linuxfromscratch.org/sources/BLFS/svn/d/docbook-xsl-doc-1.78.1.tar.bz2
# md5sum:
echo "77b63a06db2db2b692dcb96c2c64dc45 docbook-xsl-doc-1.78.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf docbook-xsl-1.78.1.tar.bz2
cd docbook-xsl-1.78.1
tar -xf ../docbook-xsl-doc-1.78.1.tar.bz2 --strip-components=1
as_root install -v -m755 -d /usr/share/xml/docbook/xsl-stylesheets-1.78.1
as_root cp -v -R VERSION common eclipse epub extensions fo highlighting html \
         htmlhelp images javahelp lib manpages params profiling \
         roundtrip slides template tests tools webhelp website \
         xhtml xhtml-1_1 \
    /usr/share/xml/docbook/xsl-stylesheets-1.78.1
as_root ln -s VERSION /usr/share/xml/docbook/xsl-stylesheets-1.78.1/VERSION.xsl
as_root install -v -m644 -D README \
                    /usr/share/doc/docbook-xsl-1.78.1/README.txt
as_root install -v -m644    RELEASE-NOTES* NEWS* \
                    /usr/share/doc/docbook-xsl-1.78.1
as_root cp -v -R doc/* /usr/share/doc/docbook-xsl-1.78.1
cd ..
as_root rm -rf docbook-xsl-1.78.1
#
# Add to installed list for this computer:
echo "docbook_xsl-1.78.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Now su to root and run configuration!
pushd $(dirname $(readlink -nf $0)) &&
su -c "./docbook_xsl-1.78.1-config.sh"
#
###################################################

