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
#cmake-3.3.1
#fltk-1.3.3
#gnutls-3.4.4.1
#libgcrypt-1.6.3
#libjpeg-turbo-1.4.1
#pixman-0.32.6
#xorg_applications 
# End Required
# Begin Recommended
#imagemagick-6.9.1-0
#linux_pam-1.2.1
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
# End Kernel
#
source ${HOME}/.blfs_profile
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "tigervnc-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://anduin.linuxfromscratch.org/sources/BLFS/conglomeration/tigervnc/tigervnc-1.6.0.tar.gz
# md5sum:
#echo "b11cc4c4d5249b9b8e355ee6f47ec4fe tigervnc-1.5.0.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
# Required file download
wget http://ftp.x.org/pub/individual/xserver/xorg-server-1.18.0.tar.bz2
#
# Required patch download
wget http://www.linuxfromscratch.org/patches/blfs/svn/tigervnc-1.6.0-xorg118-1.patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/tigervnc-1.6.0-gethomedir-1.patch
#
tar -xvf tigervnc-1.6.0.tar.gz
cd tigervnc-1.6.0
patch -Np1 -i ../tigervnc-1.6.0-xorg118-1.patch
patch -Np1 -i ../tigervnc-1.6.0-gethomedir-1.patch
mkdir -vp build
cd build
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -Wno-dev ..
make -j3
#
cp -vR ../unix/xserver unix/
tar -xf ../../xorg-server-1.18.0.tar.bz2 -C unix/xserver --strip-components=1
pushd unix/xserver
  patch -Np1 -i ../../../unix/xserver117.patch
  autoreconf -fi
  ./configure $XORG_CONFIG \
      --disable-xwayland    --disable-dri        --disable-dmx         \
      --disable-xorg        --disable-xnest      --disable-xvfb        \
      --disable-xwin        --disable-xephyr     --disable-kdrive      \
      --disable-devel-docs  --disable-config-hal --disable-config-udev \
      --disable-unit-tests  --disable-selective-werror                 \
      --disable-static      --enable-dri3                              \
      --without-dtrace      --enable-dri2        --enable-glx          \
      --enable-glx-tls      --with-pic
  make -j3 TIGERVNC_SRCDIR=`pwd`/../../../
popd
#
as_root make install
pushd unix/xserver/hw/vnc
as_root make install
popd
as_root [ -e /usr/bin/Xvnc ] || ln -svf $XORG_PREFIX/bin/Xvnc /usr/bin/Xvnc
#
as_root cp -v ${BLFSDIR}/files/usr/share/applications/vncviewer.desktop /usr/share/applications/
as_root install -vm644 ../media/icons/tigervnc_24.png /usr/share/pixmaps
as_root ln -sfv tigervnc_24.png /usr/share/pixmaps/tigervnc.png
install -Dm755 ${BLFSDIR}/files/home/profile/.vnc/xstartup $HOME/.vnc/xstartup
#
cd ..
as_root rm -rf tigervnc-1.6.0
#
# Add to installed list for this computer:
echo "tigervnc-1.6.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
