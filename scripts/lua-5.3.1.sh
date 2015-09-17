#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for lua-5.3.1
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
grep lua-5.3.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.lua.org/ftp/lua-5.3.1.tar.gz
# md5sum:
echo "797adacada8d85761c079390ff1d9961 lua-5.3.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/lua-5.3.1-shared_library-1.patch
 #
tar -xvf lua-5.3.1.tar.gz
cd lua-5.3.1
patch -Np1 -i ../lua-5.3.1-shared_library-1.patch
sed -i '/#define LUA_ROOT/s:/usr/local/:/usr/:' src/luaconf.h
make linux
# Test:
make test
#
# For some reason the BLFS instructions didn't work!
# So I modified TO_LIB and added symlinks below.
as_root make INSTALL_TOP=/usr TO_LIB="liblua.so.5.3.1" \
     INSTALL_DATA="cp -d" INSTALL_MAN=/usr/share/man/man1 install
as_root ln -sv liblua.so.5.3.1 /usr/lib/liblua.so
as_root ln -sv liblua.so.5.3.1 /usr/lib/liblua.so.5.3
as_root mkdir -pv /usr/share/doc/lua-5.3.1
as_root cp -v doc/*.{html,css,gif,png} /usr/share/doc/lua-5.3.1
cd ..
as_root rm -rf lua-5.3.1
#
as_root install -Dm644 -g root -o root files/lua.pc /usr/lib/pkgconfig/
# Add to installed list for this computer:
echo "lua-5.3.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
