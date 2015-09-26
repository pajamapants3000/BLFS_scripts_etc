#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for XYXY
#
# Dependencies
#**************
required=
recommended=
optional=
kernel=
#
# Preparation
#*************
source blfs_profile
#
PROG=
VERSION=
#TESTCMD="test"
DL_URL=
DL_ALT=
DL_ADD=
MD5=
ARCHIVE="tar.gz"
BOOTSCRIPT=
PROGGROUP=
PROGUSER=
USRCMNT=
CONFADD=
#
CONFOPTS="--prefix=/usr ${CONFADD}"
#
if ! (cat /list-${CHRISTENED}-${SURNAME} | \
        grep DPDY > /dev/null); then
    CONFOPTS="$CONFOPTS --enable-DPDY"
if (cat /list-${CHRISTENED}-${SURNAME} | \
        grep DPDN > /dev/null); then
    CONFOPTS="$CONFOPTS --disable-DPDN"
#
# Add group/user
if [ $PROGGROUP ]; then
    if ! (cat /etc/group | grep $PROGGROUP > /dev/null); then
        pathappend /usr/sbin
        as_root groupadd -g 18 $PROGGROUP
    fi
    if [ $PROGUSER ]; then
        if ! (cat /etc/passwd | grep $PROGUSER > /dev/null); then
        as_root useradd -c "${USRCMNT}" -d /var/run/${PROGUSER} \
                -u 18 -g $PROGGROUP -s /bin/false $PROGUSER
        pathremove /usr/sbin
        fi
    fi
fi
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep ${PROG}"-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ${DL_URL}/${PROG}-${VERSION}.${ARCHIVE} || [ $DL_ALT ]
# FTP/alt Download:
if (($?)) && [ $DL_ALT ]; then
    wget ${DL_ALT}/${PROG}-${VERSION}.${ARCHIVE}
#
# md5sum:
echo "${MD5} ${PROG}-${VERSION}.${ARCHIVE}" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf ${PROG}-${VERSION}.${ARCHIVE}
pushd ${PROG}-${VERSION}
perl Makefile.PL
make -j${PARALLEL}
# Test:
# Catch expected failing test and log it
if [ $TESTCMD ]; then
    make ${TESTCMD} 2>&1 | tee ../logs/"$(basename $0)"-log; \
    STAT=${PIPESTATUS[0]}; ( exit 0 )
    if (( STAT )); then
        echo "Some tests failed; log in ../$(basename $0)-log"
        echo "Pull up another terminal and check the output"
        echo "Shall we proceed? (say "'"yes"'" or "'"y"'" to proceed)"
        read PROCEED
        [ "$PROCEED" = "y" ] || [ "$PROCEED" = "yes" ]
    fi
fi
#
as_root make -j${PARALLEL} install
popd
as_root rm -rf ${PROG}-${VERSION}
#
# Add to installed list for this computer:
echo "${PROG}-${VERSION}" >> /list-${CHRISTENED}-${SURNAME}
#
(($REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Init Script
#*************
if [ $BOOTSCRIPT ]; then
    cd blfs-bootscripts-20150823
    as_root make install-${BOOTSCRIPT}
    cd ..
fi
#
###################################################
#
# Configuration
#***************
#
###################################################
