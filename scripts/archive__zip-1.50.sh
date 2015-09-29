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
grep archive__zip-1.50 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://cpan.metacpan.org/authors/id/P/PH/PHRED/Archive-Zip-1.49.tar.gz
# md5sum:
echo "35b81833e44d0001f0e1c86c72f2a6c8 Archive-Zip-1.49.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf Archive-Zip-1.49.tar.gz
cd Archive-Zip-1.49
perl Makefile.PL
make
# Test:
make test
#
as_root make install
cd ..
as_root rm -rf Archive-Zip-1.49
#
# Add to installed list for this computer:
echo "archive__zip-1.50" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
