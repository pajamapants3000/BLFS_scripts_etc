#!/bin/bash -ev
# Installation script for luarocks-2.2.2
# Updated 07/19/2015
#
# Dependencies
#**************
# Begin Required
#lua-5.3.1
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
grep luarocks-2.2.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://keplerproject.github.io/luarocks/releases/luarocks-2.2.2.tar.gz
#
tar -xvf luarocks-2.2.2.tar.gz
cd luarocks-2.2.2
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf luarocks-2.2.2
# Config files:
# The default settings are suitable for installing LuaRocks globally in your
# system while allowing both system-wide and per-user sets of rocks. User
# accounts will be able to install their own rocks in their $HOME directory,
# and the superuser can install rocks that will be available for everyone.
#
# By default LuaRocks will install itself in /usr/local, like Lua, and will use
# /usr/local/etc/luarocks/config.lua as a default path for the configuration
# file. The default system-wide rocks trees is configured as
# /usr/local/lib/luarocks, and per-user rocks install at
# $HOME/.luarocks/rocks/. Command-line scripts provided by rocks will
# be installed in /usr/local/lib/luarocks/bin/ or $HOME/.luarocks/bin/,
# respectively. The user may then add these directories to their $PATH variable. 
# Add to list of installed programs on this system
echo "luarocks-2.2.2" >> /list-$CHRISTENED"-"$SURNAME
#