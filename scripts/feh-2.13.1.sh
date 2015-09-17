#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for feh-2.13.1
#
# Dependencies
# Note: imlib2-1.4.7 must be built with giflib-5.1.1 to pass tests
#**************
# Begin Required
#libpng-1.6.18
#imlib2-1.4.7
# End Required
# Begin Recommended
#curl-7.44.0
# End Recommended
# Begin Optional
#libexif-0.6.21
#libjpeg_turbo-1.4.1
#imagemagick-6.9.1-0
#test__command-0.11
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep feh-2.13.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://feh.finalrewind.org/feh-2.13.1.tar.bz2
# md5sum:
echo "18a70487dddf43682d4acc896bfed0d3 feh-2.13.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf feh-2.13.1.tar.bz2
cd feh-2.13.1
sed -i "s:doc/feh:&-2.13.1:" config.mk
make PREFIX=/usr
# Test:
make test
#
as_root make PREFIX=/usr install
cd ..
as_root rm -rf feh-2.13.1
#
# Add to installed list for this computer:
echo "feh-2.13.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
