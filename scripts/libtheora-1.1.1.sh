#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for libtheora-1.1.1
#
# Dependencies
#**************
# Begin Required
#libogg-1.3.2
# End Required
# Begin Recommended
#libvorbis-1.3.5
# End Recommended
# Begin Optional
#sdl-1.2.15
#libpng-1.6.18
#doxygen-1.8.10
#texlive-20150521
#bibtex
#transfig
#valgrind-3.10.1
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep libtheora-1.1.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.xz
# md5sum:
echo "9eeabf1ad65b7f41533854a59f7a716d libtheora-1.1.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libtheora-1.1.1.tar.xz
pushd libtheora-1.1.1
sed -i 's/png_\(sizeof\)/\1/g' examples/png2theora.c
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
cd examples/.libs
for E in *; do
  as_root install -v -m755 $E /usr/bin/theora_${E}
done
popd
as_root rm -rf libtheora-1.1.1
#
# Add to installed list for this computer:
echo "libtheora-1.1.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################