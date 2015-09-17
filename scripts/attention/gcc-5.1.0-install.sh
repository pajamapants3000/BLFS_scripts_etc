#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gcc-5.1.0
# Part II - The Installation
##################################################
#
# Installation
#
# Only if you are very VERY sure the build is good!
#
# Run as root! Run from build folder.
##
make install
mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
chown -v -R root:root \
    /usr/lib/gcc/*linux-gnu/5.1.0/include{,-fixed}
ln -v -sf ../usr/bin/cpp /lib
ln -v -sf gcc /usr/bin/cc
install -v -dm755 /usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/5.1.0/liblto_plugin.so /usr/lib/bfd-plugins/
cd ../..
# Remove folder manually
#as_root rm -rf gcc-5.1.0
#
# Add to installed list for this computer:
echo "gcc-5.1.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################