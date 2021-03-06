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
grep "XYXY" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget XXX
# FTP/alt Download:
#wget XXX
#
# md5sum:
echo "XXX XYXY.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf XYXY.tar.gz
cd XYXY
XXX
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf XYXY
#
# Add to installed list for this computer:
echo "XYXY" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-
cd ..
#
###################################################
#
# Configuration
#***************
#
###################################################
#
# Other useful snippets
#
if ! (cat /etc/group | grep YYY > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -g 18 YYY
    as_root useradd -c "X_X_Y_Y" -d /var/run/${PROGUSER} \
            -u 18 -g YYY -s /bin/false XXYY
    pathremove /usr/sbin
fi
#
make -k check 2>&1 | tee ../logs/"$(basename $0)"-log; \
STAT=${PIPESTATUS[0]}; ( exit 0 )
if (( STAT )); then
    echo "Some tests failed; log in ../$(basename $0)-log"
    echo "Pull up another terminal and check the output"
    echo "Shall we proceed? (say "'"yes"'" or "'"y"'" to proceed)"
    read PROCEED
    [ "$PROCEED" = "y" ] || [ "$PROCEED" = "yes" ]
fi
#
