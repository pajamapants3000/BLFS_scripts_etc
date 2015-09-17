#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libxml2-2.9.2
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#python-2.7.9
##python-3.4.2
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
grep libxml2-2.9.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://xmlsoft.org/sources/libxml2-2.9.2.tar.gz
# FTP/alt Download:
#wget ftp://xmlsoft.org/libxml2/libxml2-2.9.2.tar.gz
#
# md5sum:
echo "9e6a9aca9d155737868b3dc5fd82f788 libxml2-2.9.2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional testsuite download
wget http://www.w3.org/XML/Test/xmlts20130923.tar.gz
tar -xvf libxml2-2.9.2.tar.gz
cd libxml2-2.9.2
sed \
  -e /xmlInitializeCatalog/d \
  -e 's/((ent->checked =.*&&/(((ent->checked == 0) ||\
          ((ent->children == NULL) \&\& (ctxt->options \& XML_PARSE_NOENT))) \&\&/' \
  -i parser.c
sed -e  "/The id is/{N;
                     a if (ctxt != NULL)
                    }" \
    -i valid.c
./configure --prefix=/usr --disable-static --with-history
make
# Optional fully-loaded testsuite, if downloaded
tar xf ../xmlts20130923.tar.gz
# Test:
make check > ../libxml2-2.9.2-check.log
# View results with:
#grep -E '^Total|expected' ../libxml2-2.9.2-check.log
#
as_root make install
cd ..
as_root rm -rf libxml2-2.9.2
#
# Add to installed list for this computer:
echo "libxml2-2.9.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
