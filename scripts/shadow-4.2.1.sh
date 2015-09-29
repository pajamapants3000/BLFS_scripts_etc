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
#linux_pam-1.1.8
#cracklib-2.9.2
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
grep shadow-4.2.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://pkg-shadow.alioth.debian.org/releases/shadow-4.2.1.tar.xz
# md5sum:
echo "2bfafe7d4962682d31b5eba65dba4fc8 shadow-4.2.1.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf shadow-4.2.1.tar.xz
cd shadow-4.2.1
sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;
sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
       -e 's@/var/spool/mail@/var/mail@' etc/login.defs
sed -i 's/1000/999/' etc/useradd
./configure --sysconfdir=/etc --with-group-name-max-length=32
make
#
as_root make install
as_root mv -v /usr/bin/passwd /bin
cd ..
as_root rm -rf shadow-4.2.1
#
# Add to installed list for this computer:
echo "shadow-4.2.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Configuration
#***************
as_root install -v -m644 /etc/login.defs /etc/login.defs.orig
for FUNCTION in FAIL_DELAY               \
                FAILLOG_ENAB             \
                LASTLOG_ENAB             \
                MAIL_CHECK_ENAB          \
                OBSCURE_CHECKS_ENAB      \
                PORTTIME_CHECKS_ENAB     \
                QUOTAS_ENAB              \
                CONSOLE MOTD_FILE        \
                FTMP_FILE NOLOGINS_FILE  \
                ENV_HZ PASS_MIN_LEN      \
                SU_WHEEL_ONLY            \
                CRACKLIB_DICTPATH        \
                PASS_CHANGE_TRIES        \
                PASS_ALWAYS_WARN         \
                CHFN_AUTH ENCRYPT_METHOD \
                ENVIRON_FILE
do
    sudo sed -i "s/^${FUNCTION}/# &/" /etc/login.defs
done
#
for FILE in system-account system-auth system-passwd \
               login passwd su chage system-session
do
    as_root cp -v files/$FILE /etc/pam.d/
done
for PROGRAM in chfn chgpasswd chpasswd chsh groupadd groupdel \
               groupmems groupmod newusers useradd userdel usermod
do
    as_root install -v -m644 /etc/pam.d/chage /etc/pam.d/${PROGRAM}
    as_root sed -i "s/chage/$PROGRAM/" /etc/pam.d/${PROGRAM}
done
#
# This is where we stop and check it out!
# Just su to root, and exit back.
###################################################
echo "Testing su: enter password, then exit"
su
