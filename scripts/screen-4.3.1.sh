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
#linux_pam-1.2.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep screen-4.3.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://ftp.gnu.org/gnu/screen/screen-4.3.1.tar.gz
# FTP/alt Download:
#wget ftp://ftp.gnu.org/gnu/screen/screen-4.3.1.tar.gz
#
# md5sum:
echo "5bb3b0ff2674e29378c31ad3411170ad screen-4.3.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf screen-4.3.1.tar.gz
cd screen-4.3.1
./configure --prefix=/usr                     \
            --infodir=/usr/share/info         \
            --mandir=/usr/share/man           \
            --with-socket-dir=/run/screen     \
            --with-pty-group=5                \
            --with-sys-screenrc=/etc/screenrc
make
sed -i -e "s%/usr/local/etc/screenrc%/etc/screenrc%" {etc,doc}/*
# Test:
make check
#
as_root make install
as_root install -m 644 etc/etcscreenrc /etc/screenrc
cd ..
as_root rm -rf screen-4.3.1
#
# Add to installed list for this computer:
echo "screen-4.3.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################