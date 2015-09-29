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
#libffi-3.2.1
# End Recommended
# Begin Optional
#bluez-5.32
#valgrind-3.10.1
#openssl-1.0.2d
#sqlite-3.8.11.1
#tk-8.6.4
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep python-2.7.10 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tar.xz
# md5sum:
echo "c685ef0b8e9f27b5e3db5db12b268ac6 Python-2.7.10.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# HTML Doc Download:
#wget https://docs.python.org/2.7/archives/python-2.7.10-docs-html.tar.bz2
# md5sum:
#echo "5f07d5079327be83f450ecc459ffe249 python-2.7.10-docs-html.tar.bz2" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
tar -xvf Python-2.7.10.tar.xz
cd Python-2.7.10
./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --enable-unicode=ucs4
make
# Test - one unknown fail:
# Last run the tests hanged; get this to work; extra dep?
# no extra non-optional deps on blfs so i dunno...
#make -k test
#
as_root make install
as_root chmod -v 755 /usr/lib/libpython2.7.so.1.0
cd ..
as_root rm -rf Python-2.7.10
#
# Install pip and setuptools
wget https://bootstrap.pypa.io/get-pip.py
as_root python2 get-pip.py
#
# Add to installed list for this computer:
echo "python-2.7.10" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
