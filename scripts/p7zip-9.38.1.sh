#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for p7zip-9.38.1
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#wxwidgets
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep p7zip-9.38.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/project/p7zip/p7zip/9.38.1/p7zip_9.38.1_src_all.tar.bz2
# md5sum:
echo "6cba8402ccab2370d3b70c5e28b3d651 p7zip_9.38.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf p7zip_9.38.1.tar.bz2
cd p7zip_9.38.1
sed -i -e 's/chmod 555/chmod 755/' -e 's/chmod 444/chmod 644/' install.sh
make all3
# Test:
make test
#
as_root make DEST_HOME=/usr \
     DEST_MAN=/usr/share/man \
     DEST_SHARE_DOC=/usr/share/doc/p7zip-9.38.1 install
cd ..
as_root rm -rf p7zip_9.38.1
#
# Add to installed list for this computer:
echo "p7zip-9.38.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################