#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for s_lang-2.2.4
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
#libpng-1.6.18
#pcre-8.37
#oniguruma
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep s_lang-2.2.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://space.mit.edu/pub/davis/slang/v2.2/slang-2.2.4.tar.bz2
#
# md5sum:
echo "7fcfd447e378f07dd0c0bae671fe6487 slang-2.2.4.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf slang-2.2.4.tar.bz2
cd slang-2.2.4
./configure --prefix=/usr \
            --sysconfdir=/etc \
            --with-readline=gnu
make -j1
# Test:
make check
#
as_root make install_doc_dir=/usr/share/doc/slang-2.2.4   \
             SLSH_DOC_DIR=/usr/share/doc/slang-2.2.4/slsh \
             install-all
as_root chmod -v 755 /usr/lib/libslang.so.2.2.4 \
        /usr/lib/slang/v2/modules/*.so
cd ..
as_root rm -rf slang-2.2.4
#
# Add to installed list for this computer:
echo "s_lang-2.2.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
