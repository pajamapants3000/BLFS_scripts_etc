#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for XYXY
DATE=$(date +%Y%m%d)
TIME=$(date +%H%M%S)
#
# If executed with command line options, then instead of running installer
#+the arguments should be used to modify the variables.
if [ ${#} -gt 1 ]
    sed -i "s:^${1}=.*$:${1}=${2}:"
    exit 0
fi
#
# Preparation
#*************
source blfs_profile
#
# For packages that don't support or do well with parallel build
#PARALLEL=1
#
# Name of program, with version and package/archive type
PROG=fontforge
VERSION=20150824
ARCHIVE=tar.gz
MD5=74c49c73822d642b0511718d8eeb2210
#
WORKING_DIR=$PWD
SRCDIR=${WORKING_DIR}/${PROG}-${VERSION}
#
# Downloads; obtain and verify package(s)
DL_URL=https://github.com/fontforge/fontforge/releases/download
DL_ALT=
# Prepare sources
PATCHDIR=${WORKING_DIR}/patches
PATCH=
# Configure; prepare build
PREFICKS=/usr
SYSCONFDER=/etc
LOCALST8DER=/var
# CONFIGURE: ./configure, cmake, qmake, ./autogen.sh, or other/undefined
CONFIGURE="./configure"
# Default flags
##./configure
PREFICKS_FLAG="--prefix"
SYSCONFDER_FLAG="--sysconfdir"
LOCALST8DER_FLAG="--localstatedir"
CONFIG_FLAGS="${PREFICKS_FLAG}=${PREFICKS}      \
              ${SYSCONFDER_FLAG}=${SYSCONFDER}  \
              ${LOCALST8DER_FLAG}=${LOCALST8DER}"
##cmake
#CMAKE_SRC_ROOT=${SRCDIR}
#PREFICKS_FLAG="-DCMAKE_INSTALL_PREFIX"
#CONFIG_FLAGS="${PREFICKS_FLAG}=${PREFICKS} \
#              -DCMAKE_BUILD_TYPE=Release   \
#              -Wno-dev ${CMAKE_SRC_ROOT}"
##qmake
#elif [ x${PREMAKE} == "xqmake" ]; then
#    QMAKESPEC=
#    CONFIG_FLAGS="${QMAKESPEC}"
#fi
##...?
#CONFIG_FLAGS
#
CONFIG_FLAGS="${CONFIG_FLAGS} --disable-static"
if ( cat /list-$CHRISTENED-$SURNAME | grep gtk+-2 > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} --enable-gtk2"
fi
CONFIG_FLAGS="${CONFIG_FLAGS} --docdir=/usr/share/doc/fontforge-20150824"
MAKE="make"
MAKE_FLAGS="-j${PARALLEL}"
TESTCMD=check
TEST_FLAGS="-j${PARALLEL} -k"
INSTALL="install"
INSTALL_FLAGS="-j${PARALLEL}"
#
# Additional/optional configurations: bootscript, group, user, ...
BOOTSCRIPT=
PROGGROUP=
PROGUSER=
USRCMNT=
#
#****************************************************************************#
################ No variable settings below this line! #######################
#****************************************************************************#
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
elif [ $PROGUSER ]; then
    if ! (cat /etc/passwd | grep $PROGUSER > /dev/null); then
    as_root useradd -c "${USRCMNT}" -d /var/run/${PROGUSER} \
            -u 18 -s /bin/false $PROGUSER
    pathremove /usr/sbin
    fi
fi
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "${PROG}-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ${DL_URL}/${PROG}-${VERSION}.${ARCHIVE} \
    -O ${PROG}-${VERSION}.${ARCHIVE} || FAIL_DL=1
# FTP/alt Download:
if (($FAIL_DL)) && [ $DL_ALT ]; then
    wget ${DL_ALT}/${VERSION}/${PROG}-${VERSION}.${ARCHIVE} \
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
mkdir -v ${PROG}-${VERSION}
tar -xf ${PROG}-${VERSION}.${ARCHIVE} -C ${PROG}-${VERSION} --strip-components=1
pushd ${PROG}-${VERSION}
[ ${PATCH} ] && patch -Np1 < ${PATCHDIR}/${PATCH}
#
##cmake child build
#mkdir -v build && cd build
##cmake parabuild
#mkdir ../{PROG}-build && cd ../${PROG}-build
##autogen first
#./autogen.sh
#
${CONFIGURE} ${CONFIG_FLAGS}
#
${MAKE} ${MAKE_FLAGS}
#
# Test:
if [ $TEST ]; then
    ${MAKE} ${TEST_FLAGS} ${TEST} 2>&1 | \
            tee ../logs/${PROG}-${VERSION}-${DATE}.check; \
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
as_root ${MAKE} ${INSTALL_FLAGS} ${INSTALL}
popd
as_root rm -rf ${PROG}-${VERSION}
# XXX: Version specific addition
as_root sed -e '/Exec/ s/fontforge/& -new/' \
    -i /usr/share/applications/fontforge.desktop
##cmake parabuild
#as_root rm -rf ${PROG}-build
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
    cd blfs-bootscripts-${BLFS_BOOTSCRIPTS_VER}
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
