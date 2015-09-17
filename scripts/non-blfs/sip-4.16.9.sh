#!/bin/bash -ev
# Installation script for sip-4.16.9
#
# Dependencies
#**************
# Begin Required
#python-3.4.3
#python-2.7.10
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
grep sip-4.16.9 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/pyqt/files/sip/sip-4.16.9/sip-4.16.9.tar.gz
#
tar -xvf sip-4.16.9.tar.gz
cd sip-4.16.9
python3 ./configure.py
make
#
as_root make install
cd ..
as_root rm -rf sip-4.16.9
#
# Add to installed list for this computer:
echo "sip-4.16.9" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
