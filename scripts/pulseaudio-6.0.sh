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
#json_c-0.12
#libsndfile-1.0.25
#End Required
#Begin Recommended
#alsa_lib-1.0.29
#d_bus-1.8.18
#glib-2.44.1
#libcap-2.24
#openssl-1.0.2d
#speex-1.2rc2
#xorg_libraries
# End Recommended
# Begin Optional
#avahi-0.6.31
#bluez-5.32
#check-0.9.14
#consolekit-0.4.6
#gconf-3.2.6
#gtk+-3.16.6
#libsamplerate-0.1.8
#sbc-1.3
#valgrind-3.10.1
#fftw
#jack
#libasyncns
#lirc
#orc
#tdb
#webrtc
#audioprocessing
#xen
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep pulseaudio-6.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://freedesktop.org/software/pulseaudio/releases/pulseaudio-6.0.tar.xz
# FTP/alt Download:
#wget XXX
#
# md5sum:
echo "b691e83b7434c678dffacfa3a027750e pulseaudio-6.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf pulseaudio-6.0.tar.xz
cd pulseaudio-6.0
./configure --prefix=/usr        \
            --sysconfdir=/etc    \
            --localstatedir=/var \
            --disable-bluez4     \
            --disable-rpath 
make
# Test:
make check
#
as_root make install
as_root rm /etc/dbus-1/system.d/pulseaudio-system.conf
cd ..
as_root rm -rf pulseaudio-6.0
#
grep consolekit /list-$CHRISTENED"-"$SURNAME > /dev/null ||\
sudo sed '/load-module module-console-kit/s/^/#/' \
                    -i /etc/pulse/default.pa
# Add to installed list for this computer:
echo "pulseaudio-6.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
