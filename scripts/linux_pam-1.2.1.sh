#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for linux_pam-1.2.1
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#db-6.1.26
#crackLib-2.9.5
#libtirpc-0.3.2
#prelude
#docbook_xml-4.5
#docbook_xsl-1.78.1
#fop-1.1
#libxslt-1.1.28
#w3m-0.5.3 
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep linux_pam-1.2.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://linux-pam.org/library/Linux-PAM-1.2.1.tar.bz2
# md5sum:
echo "9dc53067556d2dd567808fd509519dd6 Linux-PAM-1.2.1.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Optional documentation
wget http://linux-pam.org/documentation/Linux-PAM-1.2.0-docs.tar.bz2
# md5sum:
echo "558378b8be9b8b5c987326f4529f2130 Linux-PAM-1.2.0-docs.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf Linux-PAM-1.2.1.tar.bz2
cd Linux-PAM-1.2.1
tar -xf ../Linux-PAM-1.2.0-docs.tar.bz2 --strip-components=1
./configure --prefix=/usr \
            --sysconfdir=/etc \
            --libdir=/usr/lib \
            --enable-securedir=/lib/security \
            --docdir=/usr/share/doc/Linux-PAM-1.2.1
make
#
if ! (($REINSTALL)); then
    as_root install -v -m755 -d /etc/pam.d
    as_root tee /etc/pam.d/other << "EOF"
auth     required       pam_deny.so
account  required       pam_deny.so
password required       pam_deny.so
session  required       pam_deny.so
EOF
fi
# Test:
make check
#
if ! (($REINSTALL)); then
    as_root rm -fv /etc/pam.d/*
fi
#
as_root make install
as_root chmod -v 4755 /sbin/unix_chkpwd
for file in pam pam_misc pamc
do
  as_root mv -v /usr/lib/lib${file}.so.* /lib
  as_root ln -sfv ../../lib/$(readlink /usr/lib/lib${file}.so) /usr/lib/lib${file}.so
done
for file in other system-account system-passwd system-auth system-session login chage
do
    as_root cp -v ../files/${file} /etc/pam.d/
done
cd ..
as_root rm -rf Linux-PAM-1.2.1
#
# Add to installed list for this computer:
echo "linux_pam-1.2.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
