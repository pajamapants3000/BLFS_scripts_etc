#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for unixodbc-2.3.2
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#mini_sql
#pth-2.0.7
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep unixodbc-2.3.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.unixodbc.org/unixODBC-2.3.2.tar.gz
# FTP/alt Download:
#wget ftp://mirror.ovh.net/gentoo-distfiles/distfiles/unixODBC-2.3.2.tar.gz
#
# md5sum:
echo "5e4528851eda5d3d4aed249b669bd05b unixODBC-2.3.2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf unixODBC-2.3.2.tar.gz
cd unixODBC-2.3.2
./configure --prefix=/usr \
            --sysconfdir=/etc/unixODBC
make
#
as_root make install
cd ..
as_root rm -rf unixODBC-2.3.2
find doc -name "Makefile*" -delete
as_root chmod 644 doc/{lst,ProgrammerManual/Tutorial}/*
as_root install -v -m755 -d /usr/share/doc/unixODBC-2.3.2
as_root cp      -v -R doc/* /usr/share/doc/unixODBC-2.3.2
#
# Add to installed list for this computer:
echo "unixodbc-2.3.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################