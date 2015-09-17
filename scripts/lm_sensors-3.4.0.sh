#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for lm_sensors-3.4.0
#
# Dependencies
#**************
# Begin Required
#which-2.21
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#rrdtool
# End Optional
# Begin Kernel
#CONFIG_MODULES
#CONFIG_PCI
#CONFIG_I2C_CHARDEV
#CONFIG_HWMON
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep lm_sensors-3.4.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://dl.lm-sensors.org/lm-sensors/releases/lm_sensors-3.4.0.tar.bz2
# md5sum:
echo "c03675ae9d43d60322110c679416901a lm_sensors-3.4.0.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf lm_sensors-3.4.0.tar.bz2
cd lm_sensors-3.4.0
make PREFIX=/usr        \
     BUILD_STATIC_LIB=0 \
     MANDIR=/usr/share/man
#
as_root make PREFIX=/usr        \
     BUILD_STATIC_LIB=0 \
     MANDIR=/usr/share/man install
as_root install -v -m755 -d /usr/share/doc/lm_sensors-3.4.0
as_root cp -rv              README INSTALL doc/* \
                    /usr/share/doc/lm_sensors-3.4.0
cd ..
as_root rm -rf lm_sensors-3.4.0
#
# Add to installed list for this computer:
echo "lm_sensors-3.4.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################