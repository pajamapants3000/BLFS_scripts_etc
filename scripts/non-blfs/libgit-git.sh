#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for XYXY
#
# Dependencies
#**************
required=
recommended=
optional=(pthreads openssl libssh2 iconv)
# iconv is for OSX only; pthreads and openssl for non-Windows
kernel=
#
# Preparation
#*************
source blfs_profile
#
PROG=libgit2
VERSION=dev
#TESTCMD="-k check"
DL_URL=https://github.com/libgit2/libgit2.git
DL_ALT=
DL_ADD=
MD5=
ARCHIVE=
BOOTSCRIPT=
PROGGROUP=
PROGUSER=
USRCMNT=
CMAKEOPTS="-DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release"
CMAKEOPTS="$CMAKEOPTS -Wno-dev"
#
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
        as_root useradd -c "${USRCMNT}" -d /var/run/dbus \
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
git clone ${DL_URL}
#
pushd ${PROG}
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
as_root rm -rf ${PROG}
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

