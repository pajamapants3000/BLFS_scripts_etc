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
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "tigervnc-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://anduin.linuxfromscratch.org/sources/BLFS/conglomeration/tigervnc/tigervnc-1.5.0.tar.gz
# md5sum:
echo "b11cc4c4d5249b9b8e355ee6f47ec4fe tigervnc-1.5.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required file download
wget http://ftp.x.org/pub/individual/xserver/xorg-server-1.17.2.tar.bz2
#
# Required patch download
wget http://www.linuxfromscratch.org/patches/blfs/svn/tigervnc-1.5.0-gethomedir-1.patch
#
tar -xvf tigervnc-1.5.0.tar.gz
cd tigervnc-1.5.0
tar -xf ../xorg-server-1.17.2.tar.bz2 -C unix/xserver --strip-components=1
patch -Np1 -i ../tigervnc-1.5.0-gethomedir-1.patch
sed -i 's/iconic/nowin/' unix/vncserver
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr
make
#
pushd unix/xserver
  patch -Np1 -i ../xserver116.patch
  autoreconf -fiv
  ./configure $XORG_CONFIG \
      --disable-xwayland    --disable-dri        --disable-dmx         \
      --disable-xorg        --disable-xnest      --disable-xvfb        \
      --disable-xwin        --disable-xephyr     --disable-kdrive      \
      --disable-devel-docs  --disable-config-hal --disable-config-udev \
      --disable-unit-tests  --disable-selective-werror                 \
      --disable-static      --enable-dri3                              \
      --without-dtrace      --enable-dri2        --enable-glx          \
      --enable-glx-tls      --with-pic
  make
popd
#
as_root make install
as_root cd unix/xserver/hw/vnc
as_root make install
as_root [ -e /usr/bin/Xvnc ] || ln -svf $XORG_PREFIX/bin/Xvnc /usr/bin/Xvnc
#
as_root cp -v ../files/vncviewer.desktop /usr/share/applications/
install -Dm755 ../files/xstartup $HOME/.vnc/xstartup
#
cd ..
as_root rm -rf tigervnc-1.5.0
#
# Add to installed list for this computer:
echo "tigervnc-1.5.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#