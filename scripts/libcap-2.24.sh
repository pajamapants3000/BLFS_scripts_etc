#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Time: 0.1 SBU
#
# Begin Required
#linux_pam-1.1.8
# End Required
#
# Check for previous installation:
PROCEED="yes"
grep libcap-2.24 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.24.tar.xz
# FTP Download:
#wget ftp://ftp.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.24.tar.xz
# md5sum:
echo "d43ab9f680435a7fff35b4ace8d45b80 libcap-2.24.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf libcap-2.24.tar.xz
cd libcap-2.24
sed -i 's:LIBDIR:PAM_&:g' pam_cap/Makefile
make
#
# Optionally, disable installing static library:
sed -i '/install.*STALIBNAME/ s/^/#/' libcap/Makefile
#

as_root make prefix=/usr \
     SBINDIR=/sbin \
     PAM_LIBDIR=/lib \
     RAISE_SETFCAP=no install
as_root chmod -v 755 /usr/lib/libcap.so
as_root mv -v /usr/lib/libcap.so.* /lib
as_root ln -sfv ../../lib/libcap.so.2 /usr/lib/libcap.so
#
cd ..
as_root rm -rf libcap-2.24
#
# Add to installed list for this computer:
echo "libcap-2.24" >> /list-$CHRISTENED"-"$SURNAME
#
# Command Explanations
# sed -i '...', PAM_LIBDIR=/lib: These correct PAM module install location.
# RAISE_SETFCAP=no: This parameter skips trying to use setcap on itself. This avoids an installation error if the kernel or file system do not support extended capabilities.
#
# Installed:
# capsh
# getcap
# getpcaps
# setcap
# libcap.{so,a}
#
###################################################