#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
DATE=$(date +%Y%m%d)
TIME=$(date +%H%M%S)
#
# If executed with command line options, then instead of running installer
#+the arguments should be used to modify the variables.
if [ ${#} -gt 1 ]; then
    sed -i "s:^${1}=.*$:${1}=${2}:"
    exit 0
fi
#
# Dependencies
# Required
#qt-4.8.7
# Required runtime
#p7zip-9.38.1
# Optional Runtime
#syslinux
#extlinux
#mtools
#
# Options
#
# Preparation
#*************
source ${HOME}/.blfs_profile
# Other common preparations:
#source loadqt4
#pathappend /opt/lxqt/share XDG_DATA_DIRS
#
# For packages that don't support or do well with parallel build
#PARALLEL=1
#
# Name of program, with version and package/archive type
PROG=unetbootin
VERSION=613
ARCHIVE=tar.gz
MD5=93607004cf4dd99110c6ee75cd841b0a
#
WORKING_DIR=$PWD
SRCDIR=${WORKING_DIR}/${PROG}-${VERSION}
#
# Downloads; obtain and verify package(s)
DL_URL=http://launchpad.net
DL_ALT=
# Prepare sources
PATCHDIR=${WORKING_DIR}/patches
#PATCH=${PROG}-${VERSION}.patch
# Configure; prepare build
PREFICKS=/usr
SYSCONFDER=/etc
LOCALST8DER=/var
MANDER=/usr/share/man
DOCDER=/usr/share/doc/${PROG}-${VERSION}
# CONFIGURE: ./configure, cmake, qmake, ./autogen.sh, or other/undefined
CONFIGURE="qmake-qt4"
#
# Flags
# -j${PARALLEL} included by default; uncomment line above to unset.
CONFIG_FLAGS=""
MAKE="make"
MAKE_FLAGS=""
TEST=
TEST_FLAGS="-k"
INSTALL="install"
INSTALL_FLAGS=""
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
# Standard configuration settings: ./configure, cmake, qmake, ./autogen.sh
if [ "x${CONFIGURE:$((${#CONFIGURE}-5)):5}" = "xcmake" ]; then
    CONFIG_FLAGS="-DCMAKE_INSTALL_PREFIX=${PREFICKS} \
                  -DCMAKE_BUILD_TYPE=Release         \
                  -Wno-dev ${CONFIG_FLAGS} ${CMAKE_SRC_ROOT}"
elif [ "x${CONFIGURE:$((${#CONFIGURE}-11)):11}" = "x./configure" ]; then
    [ $CFG_PREFIX_FLAG ] || CFG_PREFIX_FLAG="--prefix"
    [ $CFG_SYSCONFDIR_FLAG ] || CFG_SYSCONFDIR_FLAG="--sysconfdir"
    [ $CFG_LOCALSTATEDIR_FLAG ] || CFG_LOCALSTATEDIR_FLAG="--localstatedir"
    CONFIG_FLAGS="${CFG_PREFIX_FLAG}=${PREFICKS}           \
                  ${CFG_SYSCONFDIR_FLAG}=${SYSCONFDER}     \
                  ${CFG_LOCALSTATEDIR_FLAG}=${LOCALST8DER} \
                  ${CONFIG_FLAGS}"
# Leave place for other possible configuration utilities to set up
# For now, just do-nothing placeholder command
elif [ "x${CONFIGURE:$((${#CONFIGURE}-5)):5}" = "xqmake" ]; then
    CONFIG_FLAGS="${CONFIG_FLAGS}"
elif [ "x${CONFIGURE:$((${#CONFIGURE}-12)):12}" = "x./autogen.sh" ]; then
    CONFIG_FLAGS="${CONFIG_FLAGS}"
else
    CONFIG_FLAGS="${CONFIG_FLAGS}"
fi
#
# Default make flags
MAKE_FLAGS="-j${PARALLEL} ${MAKE_FLAGS}"
TEST_FLAGS="-j${PARALLEL} ${TEST_FLAGS}"
INSTALL_FLAGS="-j${PARALLEL} ${INSTALL_FLAGS}"
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
grep "^${PROG//-/_}-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
if ! [ -f ${PROG}-${VERSION}.${ARCHIVE} ]; then
    wget ${DL_URL}/${PROG}/trunk/${VERSION}/+downloads/${PROG}-source-${VERSION}.${ARCHIVE} \
        -O ${PROG}-${VERSION}.${ARCHIVE} || FAIL_DL=1
    # FTP/alt Download:
    if (($FAIL_DL)) && [ $DL_ALT ]; then
        wget ${DL_URL}/${PROG}/trunk/${VERSION}/+downloads/${PROG}-source-${VERSION}.${ARCHIVE} \
        -O ${PROG}-${VERSION}.${ARCHIVE} || FAIL_DL=2
    fi
    if [ $FAIL_DL == 1 ]; then
        echo "Download failed! Find alternate link and try again."
        exit 1
    elif (($FAIL_DL)); then
        echo "${FAIL_DL} downloads failed! Find alternate link and try again."
        exit 1
    fi
fi
#
# md5sum:
echo "${MD5} ${PROG}-${VERSION}.${ARCHIVE}" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Backup previous folder if it exists
num=1
while [ -d ${PROG}-${VERSION}${INC} ]; do
    INC="-${num}"
    ((num++))
done
if [ ${num} -gt 1 ]; then
    as_root mv ${PROG}-${VERSION} ${PROG}-${VERSION}${INC}
fi
#
mkdir -v ${PROG}-${VERSION}
tar -xf ${PROG}-${VERSION}.${ARCHIVE} -C ${PROG}-${VERSION}
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
lupdate-qt4 unetbootin.pro
lrelease-qt4 unetbootin.pro
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
as_root install -o root -g root -Dm755 unetbootin /usr/bin/
as_root mkdir -pv /usr/share/unetbootin
as_root cp -v unetbootin_*.qm /usr/share/unetbootin
#
popd
as_root rm -rf ${PROG}-${VERSION}
##cmake parabuild
#as_root rm -rf ${PROG}-build
#
# Add to installed list for this computer:
echo "${PROG//-/_}-${VERSION}" >> /list-${CHRISTENED}-${SURNAME}
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
#
# Common snippets
#if (cat /list-${CHRISTENED}-${SURNAME} | grep "^XYXY-" > /dev/null); then


