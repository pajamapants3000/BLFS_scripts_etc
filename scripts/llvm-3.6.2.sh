#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
source blfs_profile
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#libffi-3.2.1
#python-2.7.10 
# End Recommended
# Begin Optional
#cmake-3.3.1
#doxygen-1.8.10
#graphviz-2.38.0
#libxml2-2.9.2
#texlive-20150521
#valgrind-3.10.1
#zip-3.0
#ocaml
#sphinx
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep llvm-3.6.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# LLVM Download:
wget http://llvm.org/releases/3.6.2/llvm-3.6.2.src.tar.xz
# md5sum:
echo "0c1ee3597d75280dee603bae9cbf5cc2 llvm-3.6.2.src.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Clang Download:
wget http://llvm.org/releases/3.6.2/cfe-3.6.2.src.tar.xz
# md5sum:
echo "ff862793682f714bb7862325b9c06e20 cfe-3.6.2.src.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Compiler RT Download:
wget  http://llvm.org/releases/3.6.2/compiler-rt-3.6.2.src.tar.xz
# md5sum:
echo "e3bc4eb7ba8c39a6fe90d6c988927f3c compiler-rt-3.6.2.src.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf llvm-3.6.2.src.tar.xz
cd llvm-3.6.2.src
# Optional packages
tar -xf ../cfe-3.6.2.src.tar.xz -C tools
tar -xf ../compiler-rt-3.6.2.src.tar.xz -C projects
mv tools/cfe-3.6.2.src tools/clang
mv projects/compiler-rt-3.6.2.src projects/compiler-rt
#
sed -e "s:/docs/llvm:/share/doc/llvm-3.6.2:" \
    -i Makefile.config.in
CC=gcc CXX=g++                   \
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --enable-libffi      \
            --enable-optimized   \
            --enable-shared      \
            --disable-assertions
make -j${PARALLEL}
# If have Sphinx, build docs
#as_root make -C docs -f Makefile.sphinx man
# Test (some fail for unknown reasons):
#make -k check-all
#
as_root make -j${PARALLEL} install
for file in /usr/lib/lib{clang,LLVM,LTO}*.a
do
  as_root test -f $file 
  as_root chmod -v 644 $file
done
unset file
# With python-2.7, install clang analyzer
as_root install -v -dm755 /usr/lib/clang-analyzer
for prog in scan-build scan-view
do
  as_root cp -rfv tools/clang/tools/$prog /usr/lib/clang-analyzer/
  as_root ln -sfv ../lib/clang-analyzer/$prog/$prog /usr/bin/
done
as_root ln -sfv /usr/bin/clang /usr/lib/clang-analyzer/scan-build/
as_root mv -v /usr/lib/clang-analyzer/scan-build/scan-build.1 /usr/share/man/man1/
unset prog
# If built docs with Sphinx
#as_root install -v -m644 docs/_build/man/* /usr/share/man/man1/
#
cd ..
as_root rm -rf llvm-3.6.2.src
#
# Add to installed list for this computer:
echo "llvm-3.6.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
