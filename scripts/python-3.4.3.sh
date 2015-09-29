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
#gdb-7.9.1
#valgrind-3.10.1
#db-6.1.26
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
grep python-3.4.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://www.python.org/ftp/python/3.4.3/Python-3.4.3.tar.xz
# md5sum:
echo "7d092d1bba6e17f0d9bd21b49e441dd5 Python-3.4.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Download:
wget https://docs.python.org/3/archives/python-3.4.3-docs-html.tar.bz2
# md5sum:
echo "6588b2c92ad43cf1d4e4b813b7e4ce99 python-3.4.3-docs-html.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf Python-3.4.3.tar.xz
cd Python-3.4.3
CXX="/usr/bin/g++"              \
./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --without-ensurepip
make
#
as_root make install
as_root chmod -v 755 /usr/lib/libpython3.4m.so
as_root chmod -v 755 /usr/lib/libpython3.so
as_root install -v -dm755 /usr/share/doc/python-3.4.3/html
as_root tar --strip-components=1 \
    --no-same-owner \
    --no-same-permissions \
    -C /usr/share/doc/python-3.4.3/html \
    -xvf ../python-3.4.3-docs-html.tar.bz2
cd ..
as_root rm -rf Python-3.4.3
#
# Install pip and setuptools
wget https://bootstrap.pypa.io/get-pip.py
as_root python3 get-pip.py
#
# Add to installed list for this computer:
echo "python-3.4.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
