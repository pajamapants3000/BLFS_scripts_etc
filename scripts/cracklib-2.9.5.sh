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
#python-2.7.10
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep cracklib-2.9.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/cracklib/cracklib-2.9.5.tar.gz
# md5sum:
echo "376790a95c1fb645e59e6e9803c78582 cracklib-2.9.5.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Word list - english
wget http://downloads.sourceforge.net/cracklib/cracklib-words-20080507.gz
tar -xvf cracklib-2.9.5.tar.gz
cd cracklib-2.9.5
sed -i '/skipping/d' util/packer.c
./configure --prefix=/usr    \
            --disable-static \
            --with-default-dict=/lib/cracklib/pw_dict
make
#
as_root make install
#
# Install word lists
as_root install -v -m644 -D    ../cracklib-words-20080507.gz \
                         /usr/share/dict/cracklib-words.gz
as_root gunzip -v                /usr/share/dict/cracklib-words.gz
as_root ln -v -sf cracklib-words /usr/share/dict/words
as_root "echo $(hostname) >>      /usr/share/dict/cracklib-extra-words"
as_root install -v -m755 -d      /lib/cracklib
as_root create-cracklib-dict     /usr/share/dict/cracklib-words \
                         /usr/share/dict/cracklib-extra-words
#
as_root mv -v /usr/lib/libcrack.so.* /lib
as_root ln -sfv ../../lib/$(readlink /usr/lib/libcrack.so) /usr/lib/libcrack.so
#
# Check proper operation of the library
make test
#
cd ..
as_root rm -rf cracklib-2.9.5
#
# Add to installed list for this computer:
echo "cracklib-2.9.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
