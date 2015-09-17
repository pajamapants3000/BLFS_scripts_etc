#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for luajit-2.0.4
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
source blfs_profile
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "luajit-2.0.4" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://luajit.org/download/LuaJIT-2.0.4.tar.gz
# FTP/alt Download:
#wget XXX
#
# md5sum:
echo "dd9c38307f2223a504cbfb96e477eca0 LuaJIT-2.0.4.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf LuaJIT-2.0.4.tar.gz
cd LuaJIT-2.0.4
make -j$PARALLEL PREFIX=/usr
#
as_root make -j$PARALLEL install PREFIX=/usr
cd ..
as_root rm -rf LuaJIT-2.0.4
#
# Add to installed list for this computer:
echo "luajit-2.0.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
