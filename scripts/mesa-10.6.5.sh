#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for mesa-10.6.5
#
# Dependencies
#**************
# Begin Required
#Xorg Libraries
#libdrm-2.4.64 
# End Required
# Begin Recommended
#elfutils-0.163
#libvdpau-1.1
#llvm-3.6.2
# End Recommended
# Begin Optional
#mesa-demos
#Wayland
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "mesa-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.freedesktop.org/pub/mesa/10.6.5/mesa-10.6.5.tar.xz
# md5sum:
echo "805092cc9b9784680c1db7aa6415517e mesa-10.6.5.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
source blfs_profile
# Recommended patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/mesa-10.6.5-add_xdemos-1.patch
tar -xvf mesa-10.6.5.tar.xz
cd mesa-10.6.5
patch -Np1 -i ../mesa-10.6.5-add_xdemos-1.patch
./configure CFLAGS='-O2' CXXFLAGS='-O2'    \
            --prefix=$XORG_PREFIX          \
            --sysconfdir=/etc              \
            --enable-texture-float         \
            --enable-gles1                 \
            --enable-gles2                 \
            --enable-osmesa                \
            --enable-xa                    \
            --enable-gbm                   \
            --enable-glx-tls               \
            --with-egl-platforms="drm,x11" \
            --with-gallium-drivers="$GALLIUM_DRIVERS"
make
make -C xdemos DEMOS_PREFIX=$XORG_PREFIX
# Test:
make check
#
as_root make install
as_root make -C xdemos DEMOS_PREFIX=$XORG_PREFIX install
# opt docs
as_root install -v -dm755 /usr/share/doc/mesa-10.6.5
as_root cp -rfv docs/* /usr/share/doc/mesa-10.6.5
cd ..
as_root rm -rf mesa-10.6.5
#
# Add to installed list for this computer:
echo "mesa-10.6.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
