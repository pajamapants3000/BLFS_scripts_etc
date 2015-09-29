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
#icu-55.1
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
grep boost-1.59.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/boost/boost_1_59_0.tar.bz2
# md5sum:
echo "6aa9a5c6a4ca1016edd0ed1178e3cb87 boost_1_59_0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf boost_1_59_0.tar.bz2
cd boost_1_59_0
sed -e '1 i#ifndef Q_MOC_RUN' \
    -e '$ a#endif'            \
    -i boost/type_traits/detail/has_binary_operator.hpp
./bootstrap.sh --prefix=/usr
./b2 stage threading=multi link=shared
# Test:
#+with python-2.7.10
pushd tools/build/test; python test_all.py; popd
#full regression - a few may fail. Long ~50SBU, 40GB on four cores.
#pushd status
#../b2 -j5 2>&1 | tee ../logs/"$(basename $0)"-log; \
#STAT=${PIPESTATUS[0]}; ( exit 0 )
#if (( STAT )); then
#    echo "Some tests failed; log in ../$(basename $0)-log"
#    echo "Pull up another terminal and check the output"
#    echo "Shall we proceed? (say "'"yes"'" or "'"y"'" to proceed)"
#    read PROCEED
#    [ "$PROCEED" = "y" ] || [ "$PROCEED" = "yes" ]
#fi
#popd
#
as_root ./b2 install threading=multi link=shared
cd ..
as_root rm -rf boost_1_59_0
#
# Add to installed list for this computer:
echo "boost-1.59.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
