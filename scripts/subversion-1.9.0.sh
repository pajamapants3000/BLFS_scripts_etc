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
#apr_util-1.5.4
#sqlite-3.8.11.1
# End Required
# Begin Recommended
#serf-1.3.8
# End Recommended
# Begin Optional
#apache-2.4.16,
#cyrusr_sasl-2.1.26,
#dbus-1.10.0,
#kdelibs-4.14.10
#python-2.7.10
#ruby-2.2.3
#swig-3.0.7
#openjdk-1.8.0.51
#dante
#jikes
#junit-4.11
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "subversion-1.9.0" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.apache.org/dist/subversion/subversion-1.9.0.tar.bz2
# md5sum:
echo "20ae7b0d4ef07eeaf73eb4e23317b495 subversion-1.9.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf subversion-1.9.0.tar.bz2
pushd subversion-1.9.0
./configure --prefix=/usr    \
            --disable-static \
            --with-apache-libexecdir
make
# with doxygen
#doxygen doc/doxygen.conf
#
# if passed --enable-javahl to configure
#make javahl
#
# Also, for the associated bindings:
make swig-pl # for Perl
make swig-py \
         swig_pydir=/usr/lib/python2.7/site-packages/libsvn \
              swig_pydir_extra=/usr/lib/python2.7/site-packages/svn # for Python
make swig-rb # for Ruby
# Test:
make check
# Also, to test the associated SWIG bindings:
make check-swig-pl
make check-swig-py
# The tests for javahl and rb (ruby) fail
as_root make install
# As needed:
as_root make install-swig-pl
as_root make install-swig-py \
        swig_pydir=/usr/lib/python2.7/site-packages/libsvn \
        swig_pydir_extra=/usr/lib/python2.7/site-packages/svn
as_root make install-swig-rb
#
popd
as_root rm -rf subversion-1.9.0
#
# Add to installed list for this computer:
echo "subversion-1.9.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

