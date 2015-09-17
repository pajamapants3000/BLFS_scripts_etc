#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for tcl-8.6.4
#
# Dependencies
#**************
# Begin Required
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
REINSTALL=0
grep tcl-8.6.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/tcl/tcl8.6.4-src.tar.gz
# md5sum:
echo "d7cbb91f1ded1919370a30edd1534304 tcl8.6.4-src.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional docs
wget http://downloads.sourceforge.net/tcl/tcl8.6.4-html.tar.gz
# md5sum:
echo "62647d87e9244a4d521c6547e097007c tcl8.6.4-html.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf tcl8.6.4-src.tar.gz
cd tcl8.6.4
# DL docs
tar -xf ../tcl8.6.4-html.tar.gz --strip-components=1
export SRCDIR=`pwd`
cd unix
./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            $([ $(uname -m) = x86_64 ] && echo --enable-64bit)
make
sed -e "s#$SRCDIR/unix#/usr/lib#" \
    -e "s#$SRCDIR#/usr/include#"  \
    -i tclConfig.sh
sed -e "s#$SRCDIR/unix/pkgs/tdbc1.0.3#/usr/lib/tdbc1.0.3#" \
    -e "s#$SRCDIR/pkgs/tdbc1.0.3/generic#/usr/include#"    \
    -e "s#$SRCDIR/pkgs/tdbc1.0.3/library#/usr/lib/tcl8.6#" \
    -e "s#$SRCDIR/pkgs/tdbc1.0.3#/usr/include#"            \
    -i pkgs/tdbc1.0.3/tdbcConfig.sh
sed -e "s#$SRCDIR/unix/pkgs/itcl4.0.3#/usr/lib/itcl4.0.3#" \
    -e "s#$SRCDIR/pkgs/itcl4.0.3/generic#/usr/include#"    \
    -e "s#$SRCDIR/pkgs/itcl4.0.3#/usr/include#"            \
    -i pkgs/itcl4.0.3/itclConfig.sh
unset SRCDIR
# Test:
make test
#
as_root make install
as_root make install-private-headers
as_root ln -v -sf tclsh8.6 /usr/bin/tclsh
as_root chmod -v 755 /usr/lib/libtcl8.6.so
# Doc install
as_root mkdir -v -p /usr/share/doc/tcl-8.6.4
as_root cp -v -r  ../html/* /usr/share/doc/tcl-8.6.4
cd ../..
as_root rm -rf tcl8.6.4
#
# Add to installed list for this computer:
echo "tcl-8.6.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
