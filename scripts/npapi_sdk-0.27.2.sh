#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for npapi_sdk-0.27.2
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
grep npapi_sdk-0.27.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://bitbucket.org/mgorny/npapi-sdk/downloads/npapi-sdk-0.27.2.tar.bz2
# md5sum:
echo "e81db61e206cd615cf56c4a9f301e636 npapi-sdk-0.27.2.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf npapi-sdk-0.27.2.tar.bz2
cd npapi-sdk-0.27.2
./configure --prefix=/usr
#
as_root make install
cd ..
as_root rm -rf npapi-sdk-0.27.2
#
# Add to installed list for this computer:
echo "npapi_sdk-0.27.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################