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
grep uri-1.69 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.cpan.org/authors/id/E/ET/ETHER/URI-1.69.tar.gz
#
# md5sum:
echo "3c56aee0300bce5a440ccbd558277ea0 URI-1.69.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf URI-1.69.tar.gz
cd URI-1.69
perl Makefile.PL
make
make test
#
as_root make install
cd ..
as_root rm -rf URI-1.69
#
# Add to installed list for this computer:
echo "uri-1.69" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################