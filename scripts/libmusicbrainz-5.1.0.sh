#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libmusicbrainz-5.1.0
#
# Dependencies
#**************
# Begin Required
#cmake-3.1.3
#libxml2-2.9.2
#neon-0.30.1 
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.9.1
DOXYGEN=0
# End Optional
# Begin Kernel
# End Kernel
#
# Check for optional dependencies
#********************************
grep doxygen /list-$CHRISTENED"-"$SURNAME > /dev/null && ((DOXYGEN++))
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libmusicbrainz-5.1.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://github.com/metabrainz/libmusicbrainz/releases/download/release-5.1.0/libmusicbrainz-5.1.0.tar.gz
# md5sum:
echo "4cc5556aa40ff7ab8f8cb83965535bc3 libmusicbrainz-5.1.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libmusicbrainz-5.1.0.tar.gz
cd libmusicbrainz-5.1.0
mkdir build
cd    build
cmake -DCMAKE_INSTALL_PREFIX=/usr ..
make
# with doxygen, build API docs
if (($DOXYGEN)); then
    doxygen ../Doxyfile
fi
#
as_root make install
# with doxygen, install API docs
if (($DOXYGEN)); then
    as_root rm -rf /usr/share/doc/libmusicbrainz-5.1.0
    as_root cp -vr docs/ /usr/share/doc/libmusicbrainz-5.1.0
fi
#
cd ../..
as_root rm -rf libmusicbrainz-5.1.0
#
# Add to installed list for this computer:
echo "libmusicbrainz-5.1.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
