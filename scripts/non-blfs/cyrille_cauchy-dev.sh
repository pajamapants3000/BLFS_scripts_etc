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
required=
recommended=
optional=
kernel=
#
# Preparation
#*************
source blfs_profile
#
PROG=cyrille-cauchy
VERSION=814aa99d9341
#TESTCMD="-k check"
DL_URL=https://bitbucket.org/cyrille/cauchy/get
DL_ALT=
DL_ADD=
MD5=ed3eef3efb5be16b7a0e56a4dcecfafb
ARCHIVE="zip"
BOOTSCRIPT=
PROGGROUP=
PROGUSER=
USRCMNT=
CMAKEOPTS="-DCMAKE_INSTALL_PREFIX=/usr"
#
# TODO: make DPDY/DPDN loop parameters over deps
#if ! (cat /list-${CHRISTENED}-${SURNAME} | \
#        grep DPDY > /dev/null); then
#    CMAKEOPTS="$CMAKEOPTS -DCMAKE_WITH_DPDY"
#if (cat /list-${CHRISTENED}-${SURNAME} | \
#        grep DPDN > /dev/null); then
#    CMAKEOPTS="$CMAKEOPTS -DCMAKE_WITH_DPDN"
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
wget ${DL_URL}/${VERSION}.${ARCHIVE} \
    -O ${PROG}-${VERSION}.${ARCHIVE} || FAIL_DL=1
# FTP/alt Download:
if (($FAIL_DL)) && [ $DL_ALT ]; then
    wget ${DL_ALT}/${PROG}-${VERSION}.${ARCHIVE} \
    -O ${PROG}-${VERSION}.${ARCHIVE} || FAIL_DL=2
fi
if [ $FAIL_DL == 1 ]; then
    echo "Download failed! Find alternate link and try again."
    exit 1
elif (($FAIL_DL)); then
    echo "${FAIL_DL} downloads failed! Find alternate link and try again."
    exit 1
fi
#
# md5sum:
echo "${MD5} ${PROG}-${VERSION}.${ARCHIVE}" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
unzip ${PROG}-${VERSION}.${ARCHIVE}
pushd ${PROG}-${VERSION}
mkdir -v build
cd       build
cmake $CMAKEOPTS ..
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

