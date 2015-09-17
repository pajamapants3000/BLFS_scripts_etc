#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for docbook_utils-0.6.14
#
# Dependencies
#**************
# Begin Required
#openjade-1.3.2
#docbook_dsssl-1.79
#docbook-3.1
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#sgmlspm-1.1
#lynx-2.8.8rel.2
#links-2.10
#w3m-0.5.3
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep docbook_utils-0.6.14 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://sources.redhat.com/pub/docbook-tools/new-trials/SOURCES/docbook-utils-0.6.14.tar.gz
# md5sum:
echo "6b41b18c365c01f225bc417cf632d81c docbook-utils-0.6.14.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/docbook-utils-0.6.14-grep_fix-1.patch
tar -xvf docbook-utils-0.6.14.tar.gz
cd docbook-utils-0.6.14
patch -Np1 -i ../docbook-utils-0.6.14-grep_fix-1.patch
sed -i 's:/html::' doc/HTML/Makefile.in
./configure --prefix=/usr --mandir=/usr/share/man 
make
#
as_root make docdir=/usr/share/doc install
for doctype in html ps dvi man pdf rtf tex texi txt
do
    as_root ln -svf docbook2$doctype /usr/bin/db2$doctype
done
cd ..
as_root rm -rf docbook-utils-0.6.14
#
# Add to installed list for this computer:
echo "docbook_utils-0.6.14" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################