#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for XYXY
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
#*************
#python-2.7.10
#
# Options
#********
#
# Preparation
#*************
source blfs_profile
export PYTHON=/usr/bin/python2
# Other common preparations:
#source loadqt4
#pathappend /opt/lxqt/share XDG_DATA_DIRS
#
# Name of program, with version and package/archive type
PROG=node
VERSION=v4.1.1
ARCHIVE=tar.xz
MD5=5d3d806527cf179db119a66279e123af
SHA1=
#
WORKING_DIR=$PWD
SRCDIR=${WORKING_DIR}/${PROG}-${VERSION}
#
# Downloads; obtain and verify package(s)
DL_URL=https://nodejs.org/dist
DL_ALT=
REPO=
# VCS=[git,hg,svn,...]
#VCS=${VERSION}
BRANCH=master
# Prepare sources - PATCHDIR default is in blfs_profile
#PATCHDIR=${WORKING_DIR}/patches
#PATCH=${PROG}-${VERSION}.patch
# Configure; prepare build
PREFICKS=/usr
SYSCONFDER=/etc
LOCALST8DER=/var
MANDER=/usr/share/man
DOCDER=/usr/share/doc/${PROG}-${VERSION}
# CONFIGURE: ./configure, cmake, qmake, ./autogen.sh, or other/undefined
CONFIGURE="./configure"
#
# Flags
# -j${PARALLEL} included by default; uncomment this to unset.
#PARALLEL=1
# Default for cmake is to build in build subdirectory, but some programs
#+demand building in a directory that is paralleli to (a sibling of) source.
#CMAKE_PARALLEL=1
# Another common cmake parameter is the build type; defaults to Release or
#+uncomment below
#CBUILDTYPE=RelWithDebInfo
#
CONFIG_FLAGS=""
MAKE="make"
MAKE_FLAGS=""
TEST="test"
TEST_FLAGS="-k"
INSTALL="install"
INSTALL_FLAGS=""
#
# Additional/optional configurations: bootscript, group, user, ...
BOOTSCRIPT=
PROGGROUP=
PROGGROUPNUM=
PROGUSER=
PROGUSERNUM=${PROGGROUPNUM}
USRCMNT=
#
#****************************************************************************#
################ No variable settings below this line! #######################
#****************************************************************************#
#
# Standard configuration settings: ./configure, cmake, qmake, ./autogen.sh
if [ "x${CONFIGURE:$((${#CONFIGURE}-5)):5}" = "xcmake" ]; then
    if ((${CMAKE_PARALLEL})); then
        CMAKE_SRC_ROOT=../${PROG}-${VERSION}
    else
        CMAKE_SRC_ROOT=..
    fi
    [ ${CBUILDTYPE} ] || CBUILDTYPE="Release"
    CONFIG_FLAGS="-DCMAKE_INSTALL_PREFIX=${PREFICKS} \
                  -DCMAKE_BUILD_TYPE=Release         \
                  -Wno-dev ${CONFIG_FLAGS} ${CMAKE_SRC_ROOT}"
elif [ "x${CONFIGURE:$((${#CONFIGURE}-11)):11}" = "x./configure" ]; then
    [ $CFG_PREFIX_FLAG ] || CFG_PREFIX_FLAG="--prefix"
    [ $CFG_SYSCONFDIR_FLAG ] || CFG_SYSCONFDIR_FLAG="--sysconfdir"
    [ $CFG_LOCALSTATEDIR_FLAG ] || CFG_LOCALSTATEDIR_FLAG="--localstatedir"
    CONFIG_FLAGS="${CFG_PREFIX_FLAG}=${PREFICKS}           \
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
if [ ${PROGGROUP} ]; then
    if ! (cat /etc/group | grep ${PROGGROUP} > /dev/null); then
        pathappend /usr/sbin
        as_root groupadd -g ${PROGGROUPNUM} ${PROGGROUP}
    fi
    if [ ${PROGUSER} ]; then
        if ! (cat /etc/passwd | grep $PROGUSER > /dev/null); then
        as_root useradd -c "${USRCMNT}" -d /var/run/${PROGUSER} \
                -u ${PROGUSERNUM} -g $PROGGROUP -s /bin/false $PROGUSER
        pathremove /usr/sbin
        fi
    fi
elif [ $PROGUSER ]; then
    if ! (cat /etc/passwd | grep $PROGUSER > /dev/null); then
    as_root useradd -c "${USRCMNT}" -d /var/run/${PROGUSER} \
            -u ${PROGUSERNUM} -s /bin/false $PROGUSER
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
if [ ${VCS} ]; then
    if [ ${VCS} == "git" -o ${VCS} == "hg" ]; then
        VCS_CMD="clone"
        BRANCH_FLAG="-b"
    elif [ ${VCS} == "svn" ]; then
        VCS_CMD="co"
        BRANCH_FLAG=
    else
        echo "error: unkown value for VCS; aborting."
        exit 1
    fi
    ${VCS} ${VCS_CMD} ${BRANCH_FLAG} ${BRANCH} ${REPO} ${PROG}-${VERSION}
else
    if ! [ -f ${PROG}-${VERSION}.${ARCHIVE} ]; then
        wget ${DL_URL}/${VERSION}/${PROG}-${VERSION}.${ARCHIVE} \
            -O ${PROG}-${VERSION}.${ARCHIVE} || FAIL_DL=1
        # FTP/alt Download:
        if (($FAIL_DL)) && [ $DL_ALT ]; then
            wget ${DL_ALT}/${VERSION}/${PROG}-${VERSION}.${ARCHIVE} \
            -O ${PROG}-${VERSION}.${ARCHIVE} || FAIL_DL=2
        fi
        if [ $((FAIL_DL)) == 1 ]; then
            echo "Download failed! Find alternate link and try again."
            exit 1
        elif (($FAIL_DL)); then
            echo "${FAIL_DL} downloads failed! Find alternate link and try again."
            exit 1
        fi
    fi
#
    # checksum:
    if [ ${MD5} ]; then
        echo "${MD5} ${PROG}-${VERSION}.${ARCHIVE}" | md5sum -c ;\
            ( exit ${PIPESTATUS[0]} )
    elif [ ${SHA1} ]; then
        echo "${SHA1} ${PROG}-${VERSION}.${ARCHIVE}" | shasum -c ;\
            ( exit ${PIPESTATUS[0]} )
    fi
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
    tar -xf ${PROG}-${VERSION}.${ARCHIVE} -C ${PROG}-${VERSION} --strip-components=1
fi # End "if [ ${VCS} ]..."
#
pushd ${PROG}-${VERSION}
[ ${PATCH} ] && patch -Np1 < ${PATCHDIR}/${PATCH}
#
if [ "x${CONFIGURE:$((${#CONFIGURE}-5)):5}" = "xcmake" ]; then
    if ((${CMAKE_PARALLEL})); then
        mkdir ../{PROG}-build && cd ../${PROG}-build
    else
        mkdir -v build && cd build
    fi
fi
##autogen first
#./autogen.sh
#
if [ "${CONFIGURE}" ]; then
    ${CONFIGURE} ${CONFIG_FLAGS}
fi
#
${MAKE} ${MAKE_FLAGS}
#
# Test:
if [ "$TEST" ]; then
    [ -d "${WORKING_DIR}/logs" ] || mkdir -v ${WORKING_DIR}/logs
    ${MAKE} ${TEST_FLAGS} ${TEST} 2>&1 | \
        tee ${WORKING_DIR}/logs/${PROG}-${VERSION}-${DATE}.check || (exit 0)
    STAT=${PIPESTATUS[0]}
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
##cmake parabuild
if [ "x${CONFIGURE:$((${#CONFIGURE}-5)):5}" = "xcmake" ] &&
        ((${CMAKE_PARALLEL})); then
    as_root rm -rf ${PROG}-build
fi
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


