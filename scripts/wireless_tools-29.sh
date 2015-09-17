#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for wireless_tools-29
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
#WIFI
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "wireless_tools-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/wireless_tools.29.tar.gz
# md5sum:
echo "e06c222e186f7cc013fd272d023710cb wireless_tools.29.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf wireless_tools.29.tar.gz
cd wireless_tools.29
make
#
as_root make PREFIX=/usr INSTALL_MAN=/usr/share/man install
cd ..
as_root rm -rf wireless_tools.29
#
# Add to installed list for this computer:
echo "wireless_tools-29" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
