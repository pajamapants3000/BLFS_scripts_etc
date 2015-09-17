#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for gcc-5.1.0
# Part I - The Build
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#dejagnu-1.5.3
# End Recommended
# Begin Optional
#valgrind-3.10.1
#gdb-7.9.1
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
grep gcc-5.1.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://ftp.gnu.org/gnu/gcc/gcc-5.1.0/gcc-5.1.0.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.gnu.org/gnu/gcc/gcc-5.1.0/gcc-5.1.0.tar.bz2
#
# md5sum:
echo "d5525b1127d07d215960e6051c5da35e gcc-5.1.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/gcc-5.1.0-upstream_fixes-1.patch
tar -xvf gcc-5.1.0.tar.bz2
cd gcc-5.1.0
patch -Np1 -i ../gcc-5.1.0-upstream_fixes-1.patch
mkdir ../gcc-build
cd    ../gcc-build
../gcc-5.1.0/configure                               \
    --prefix=/usr                                    \
    --disable-multilib                               \
    --with-system-zlib                               \
    --enable-languages=c,c++,fortran,go,objc,obj-c++
make -j$PARALLEL
# Test:
ulimit -s 32768
make -k check
#
# Obtain test summary:
../gcc-5.1.0/contrib/test_summary
#
# Stop and check the results. If you are really
#+sure the build is good, su to root and run
#+the installation script
#+$su
#+$../../scripts/attention/gcc-5.1.0-install.sh
#
###################################################
