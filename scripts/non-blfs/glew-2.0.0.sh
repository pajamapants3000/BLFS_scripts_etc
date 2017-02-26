#!/bin/bash -ev
#
#    ***    Installation script     ***
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# License   : See LICENSE in parent folder
# Updated   : 02/12/2016
#
# TODO: Override or pass options via command line
# TODO: Clean it up! Make configuration more obvious
# TODO: Separate executable script and package configuration
# TODO: Run sed to fix logfile location as reported in error message
# TODO: Create library to source (functions file) for common tasks
#+     +like checking for the installation of a package, downloading
#+     +and testing checksum, avoiding duplicates and saving old builds, etc.
# TODO: Create a list of downloads, each with location info and checksum
#
DATE=$(date +%Y%m%d)
TIME=$(date +%H%M%S)
#
# If executed with command line options, then instead of running installer
#+the arguments should be used to modify the variables.
if [ ${#} -gt 1 ]; then
    sed -i "s:^${1}=.*$:${1}=${2}:"g ${0}
    exit 0
fi
#
# Dependencies
#*************
#
# Preparation
#*************
source ${HOME}/.blfs_profile
# Other common preparations:
#source loadqt4
#pathappend /opt/lxqt/share XDG_DATA_DIRS
#
# Options
#********
# Uncomment to keep build files and sources
#PRESERVE_BUILD=1
# Build only or install only (DO NOT UNCOMMENT BOTH! - TODO)
#BUILD_ONLY=1
#INSTALL_ONLY=1
# Retain source downloads
#RETAIN_DL=1
# Uncomment one to force including or skipping end configuration, resp.
#TREATASNEW=1
#TREATASOLD=1
#*******************************************************************
# Additional Option processing  (no settings here!)
#******************************
# This is where we check for any requirements and disable any options
#+that the user has specified but cannot be installed
# TODO: Add warnings for any options that are disabled here
# E.g.
#if ((SOMETHING)); then
#    if (cat /list-${CHRISTENED}-${SURNAME} | \
#           grep '^something' > /dev/null); then
#       SOMETHING=0
#    fi
#fi
#*******************************************************************
#
# Name of program, with version and package/archive type
PROG=glew
# Alternate program name; in case it doesn't match my conventions;
# My conventions are: no capitals; only '-' between name and version,
#+replace any other '-' with '_'. PROG_ALT fits e.g. download url.
PROG_ALT=${PROG}
VERSION=2.0.0
ARCHIVE=tgz
#
# Useful paths
# This is the directory in which we store any downloaded files; by default it
#+is the directory from which this script was executed.
WORKING_DIR=$PWD
# This is where the root of the package directory will be found
PKGDIR=${WORKING_DIR}/${PROG}-${VERSION}
# This is where the sources are
SRCDIR=${PKGDIR}
# Source dir build
BUILDDIR=${SRCDIR}
# Subdirectory build
#BUILDDIR=${SRCDIR}/build
# Parallel-directory build
#BUILDDIR=${SRCDIR}/../${PROG}-build
# Directory containing this script
SCRIPTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#
# Downloads; obtain and verify package(s); or specify repo to clone and type
DL_URL=https://sourceforge.net/projects/glew/files
DL_ALT=
MD5=2a2cd7c98f13854d2fcddae0d2b20411
SHASUM=
SHAALG=1
REPO=
# VCS=[git,hg,svn,...]; usually used as VERSION
#VCS=${VERSION}
BRANCH=master
# Prepare sources - PATCHDIR default is in blfs_profile; only specify non-def.
#PATCHDIR=${WORKING_DIR}/patches
#PATCH=${PROG}-${VERSION}.patch
if [ ${PATCH} ]; then
    [ -f ${PATCHDIR}/${PATCH} ] ||
        (echo "Patch ${PATCHDIR}/${PATCH} needed but not found" && exit 1)
fi
# Configure; prepare build
PREFICKS=/usr
SYSCONFDER=/etc
#SYSCONFDER=${PREFICKS}/etc
LOCALST8DER=/var
#LOCALST8DER=${PREFICKS}/var
MANDER=${PREFICKS}/share/man
DOCDER=${PREFICKS}/share/doc/${PROG}-${VERSION}
# CONFIGURE: ${SRCDIR}/configure, cmake, qmake, ./autogen.sh, or other/undefined/blank
#CONFIGURE="${SRCDIR}/configure"
#
# Flags
#*******
# -j${PARALLEL} included by default; uncomment this to force nonparallel build
#PARALLEL=1
#
# CMake
#^^^^^^^
# Use this if CMake source root is different from SRCDIR
#CMAKE_SRC_ROOT=
# Another common cmake parameter is the build type; defaults to Release or
#+uncomment below
#CBUILDTYPE=RelWithDebInfo
#Specify CMake generator (only if non-standard; will set automatically below)
#CMAKE_GEN='Unix Makefiles'
#
# Pass them in... (these are in addition to the defaults; see below)
CONFIG_FLAGS=""
MAKE_FLAGS="GLEW_PREFIX=${PREFICKS} GLEW_DEST=${PREFICKS}"
TEST=
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
# Common commands
INSTALL_USER='install -v -Dm644'
INSTALL_BINUSER='install -v -Dm755'
INSTALL_DIRUSER='install -vd'
INSTALL_ROOT="as_root ${INSTALL_USER} -o root -g root"
INSTALL_BINROOT="as_root ${INSTALL_BINUSER} -o root -g root"
INSTALL_DIRROOT="as_root ${INSTALL_DIRUSER} -o root -g root"
#****************************************************************************#
################ No variable settings below this line! #######################
#****************************************************************************#
#
# Standard configuration settings
#*********************************
# CMake
#^^^^^^^
if [ "x${CONFIGURE:$((${#CONFIGURE}-5)):5}" = "xcmake" ]; then
    [ "${CMAKE_SRC_ROOT}" ] || CMAKE_SRC_ROOT=${SRCDIR}
    [ "${CBUILDTYPE}" ]     || CBUILDTYPE="Release"
    [ "${CMAKE_GEN}" ]      ||  if (which ninja); then
                                    CMAKE_GEN="Ninja"
                                    MAKE="ninja"
                                else
                                    CMAKE_GEN="Unix Makefiles"
                                    MAKE="make"
                                fi
    CONFIG_FLAGS="-DCMAKE_INSTALL_PREFIX=${PREFICKS} \
                  -DCMAKE_BUILD_TYPE=${CBUILDTYPE}   \
                  -Wno-dev ${CONFIG_FLAGS} ${CMAKE_SRC_ROOT}"
# configure
#^^^^^^^^^^^
elif [ "x${CONFIGURE:$((${#CONFIGURE}-10)):10}" = "x/configure" ]; then
    [ "${CFG_PREFIX_FLAG}" ]        || CFG_PREFIX_FLAG="--prefix"
    [ "${CFG_SYSCONFDIR_FLAG}" ]    || CFG_SYSCONFDIR_FLAG="--sysconfdir"
    [ "${CFG_LOCALSTATEDIR_FLAG}" ] || CFG_LOCALSTATEDIR_FLAG="--localstatedir"
    [ "${CFG_DOCDIR_FLAG}" ]        || CFG_DOCDIR_FLAG="--docdir"
    [ "${CFG_MANDIR_FLAG}" ]        || CFG_MANDIR_FLAG="--mandir"
    [[ ${PREFICKS} ]] &&
            CONFIG_FLAGS="${CONFIG_FLAGS} ${CFG_PREFIX_FLAG}=${PREFICKS}" || (exit 0)
    [[ ${SYSCONFDER} ]] &&
            CONFIG_FLAGS="${CONFIG_FLAGS} ${CFG_SYSCONFDIR_FLAG}=${SYSCONFDER}" || (exit 0)
    [[ ${LOCALST8DER} ]] &&
            CONFIG_FLAGS="${CONFIG_FLAGS} ${CFG_LOCALSTATEDIR_FLAG}=${LOCALST8DER}" || (exit 0)
    [[ ${DOCDER} ]] &&
            CONFIG_FLAGS="${CONFIG_FLAGS} ${CFG_DOCDIR_FLAG}=${DOCDER}" || (exit 0)
    [[ ${MANDER} ]] &&
            CONFIG_FLAGS="${CONFIG_FLAGS} ${CFG_MANDIR_FLAG}=${MANDER}" || (exit 0)
    MAKE="make"
# Leave place for other possible configuration utilities to set up
# For now, just do-nothing placeholder commands
# QMake
#^^^^^^^
elif [ "x${CONFIGURE:$((${#CONFIGURE}-5)):5}" = "xqmake" ]; then
    CONFIG_FLAGS="${CONFIG_FLAGS}"
    MAKE="make"
# Autogen
#^^^^^^^^^
elif [ "x${CONFIGURE:$((${#CONFIGURE}-11)):11}" = "x/autogen.sh" ]; then
    CONFIG_FLAGS="${CONFIG_FLAGS}"
    MAKE="make"
# Default
#^^^^^^^^^
else
    CONFIG_FLAGS="${CONFIG_FLAGS}"
    MAKE="make"
fi
#
# Default make flags
#********************
if [ "x${MAKE}" == "xmake" ]; then
    MAKE_FLAGS="   -j${PARALLEL} ${MAKE_FLAGS}"
    TEST_FLAGS="   -j${PARALLEL} ${TEST_FLAGS}"
    INSTALL_FLAGS="-j${PARALLEL} ${INSTALL_FLAGS}"
elif [ "x${MAKE}" == "xninja" ]; then
    MAKE_FLAGS="   ${MAKE_FLAGS}"
    TEST_FLAGS="   ${TEST_FLAGS}"
    INSTALL_FLAGS="${INSTALL_FLAGS}"
else
    MAKE_FLAGS="   ${MAKE_FLAGS}"
    TEST_FLAGS="   ${TEST_FLAGS}"
    INSTALL_FLAGS="${INSTALL_FLAGS}"
fi
#
# Create Group and/or User
#**************************
if [ "${PROGGROUP}" ]; then
    if ! (cat /etc/group | grep ${PROGGROUP} > /dev/null); then
        pathappend /usr/sbin
        as_root groupadd -g ${PROGGROUPNUM} ${PROGGROUP}
    fi
    if [ "${PROGUSER}" ]; then
        if ! (cat /etc/passwd | grep $PROGUSER > /dev/null); then
        as_root useradd -c "${USRCMNT}" -d /var/run/${PROGUSER} \
                -u ${PROGUSERNUM} -g $PROGGROUP -s /bin/false $PROGUSER
        pathremove /usr/sbin
        fi
    fi
elif [ "${PROGUSER}" ]; then
    if ! (cat /etc/passwd | grep $PROGUSER > /dev/null); then
    as_root useradd -c "${USRCMNT}" -d /var/run/${PROGUSER} \
            -u ${PROGUSERNUM} -s /bin/false $PROGUSER
    pathremove /usr/sbin
    fi
fi
#
# Check for previous installation
#*********************************
PROCEED="yes"
REINSTALL=0
grep "^${PROG//-/_}-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ "${PROCEED}" = "yes" ] || [ "${PROCEED}" = "y" ] || exit 0
#
((TREATASNEW)) && REINSTALL=0
((TREATASOLD)) && REINSTALL=1
if ! ((INSTALL_ONLY)); then # Makes possible to install an already built src
# Obtain package
#****************
if [ "${VCS}" ]; then
    if [ "${VCS}" == "git" -o ${VCS} == "hg" ]; then
        VCS_CMD="clone"
        BRANCH_FLAG="-b"
    elif [ "${VCS}" == "svn" ]; then
        VCS_CMD="co"
        # With subversion, branch is part of the repo path
        BRANCH_FLAG=
        if [[ "x${BRANCH}" == "xmaster" || "x${BRANCH}" == "xtrunk" ||
              "x${BRANCH}" == "x" ]]; then
            if [[ $(basename ${REPO}) != "trunk" ]]; then
                REPO=${REPO}/trunk
            fi
        else
            if [[ $(basename ${REPO}) == "trunk" ]]; then
                REPO=$(dirname ${REPO})/branches/${BRANCH}
            else
                REPO=${REPO}/branches/${BRANCH}
            fi
        fi
        BRANCH=
    else
        echo "error: unkown value for VCS; aborting."
        exit 1
    fi
#
    # Preserve any previous builds; Ensure empty target directory
    #*************************************************************
    num=1
    INC=
    while [ -d ${PKGDIR}${INC} ]; do
        INC="-${num}"
        ((num++))
    done
    if ((INC)); then
        as_root mv ${PKGDIR} ${PKGDIR}${INC}
    fi
#
    # Clone Repository
    #******************
    ${VCS} ${VCS_CMD} ${BRANCH_FLAG} ${BRANCH} ${REPO} ${PKGDIR}
#
else
    # Download Package
    #******************
    if ! [ -f ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE} ]; then
        wget ${DL_URL}/${PROG_ALT}/${VERSION}/${PROG_ALT}-${VERSION}.${ARCHIVE} \
            -O ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE} || FAIL_DL=1
        # FTP/alt Download:
        if (($FAIL_DL)) && [ "$DL_ALT" ]; then
            wget ${DL_ALT}/${PROG_ALT}-${VERSION}.${ARCHIVE} \
            -O ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE} &&
            FAIL_DL=0 || FAIL_DL=2
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
    # Verify package
    #****************
    if [ "${SHASUM}" ]; then
        echo "${SHASUM}  ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE}" |
                shasum -a ${SHAALG} -c ;\
            ( exit ${PIPESTATUS[0]} )
    elif [ "${MD5}" ]; then
        echo "${MD5} ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE}" | md5sum -c ;\
            ( exit ${PIPESTATUS[0]} )
    fi
#
    # Preserve any previous builds
    #******************************
    num=1
    INC=
    while [ -d ${PKGDIR}${INC} ]; do
        INC="-${num}"
        ((num++))
    done
    if ((INC)); then
        as_root mv ${PKGDIR} ${PKGDIR}${INC}
    fi
#
    # Extract package
    #*****************
    mkdir -v ${PKGDIR}
    tar -xf ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE} \
            -C ${PKGDIR} --strip-components=1
fi # End "if [ ${VCS} ]..."
#
# Begin Installation
#********************
# Change to source directory
#^^^^^^^^^^^^^^^^^^^^^^^^^^^
pushd ${SRCDIR}
# Apply patch if necessary
#^^^^^^^^^^^^^^^^^^^^^^^^^^
[ "${PATCH}" ] && patch -Np1 < ${PATCHDIR}/${PATCH} || (exit 0)
#
# Create build directory
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[ -d ${BUILDDIR} ] || mkdir -v ${BUILDDIR}
pushd ${BUILDDIR}
#
# Autogen if necessary
#^^^^^^^^^^^^^^^^^^^^^
#${SRCDIR}/autogen.sh
#
# ... or autoreconf if only configure.ac or configure.in are present
#autoreconf ${SRCDIR}
#
# Pre-config -- additional actions to take before running configuration
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
#
# Configure
#^^^^^^^^^^^
if [ "${CONFIGURE}" ]; then
    if [ ${CMAKE_GEN} ]; then
        ${CONFIGURE} -G "${CMAKE_GEN}" ${CONFIG_FLAGS}
    else
        ${CONFIGURE} ${CONFIG_FLAGS}
    fi
fi
#
# Post-config modifications before building
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
#
# Build
#^^^^^^^
${MAKE} ${MAKE_FLAGS}
#
#
# Post-build modifications before testing
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#
# Test (optional)
#^^^^^^^^^^^^^^^^^
if [ "${TEST}" ]; then
    [ -d ${WORKING_DIR}/logs ] || mkdir -v ${WORKING_DIR}/logs
    ${MAKE} ${TEST_FLAGS} ${TEST} 2>&1 | \
        tee ${WORKING_DIR}/logs/${PROG}-${VERSION}-${DATE}.check || (exit 0)
    STAT=${PIPESTATUS[0]}
    if (( STAT )); then
        echo "Some tests failed; log in ../logs/$(basename $0)-log"
        echo "Pull up another terminal and check the output"
        echo "Shall we proceed? (say "'"yes"'" or "'"y"'" to proceed)"
        read PROCEED
        [ "$PROCEED" = "y" ] || [ "$PROCEED" = "yes" ]
    fi
fi
#
fi # ! ((INSTALL_ONLY))
if ((BUILD_ONLY)); then
    echo "${PROG}-${VERSION} built successfully! No changes were made."
    echo "Build can be found in ${BUILDDIR}"
    exit 0
elif ((INSTALL_ONLY)); then
    WORKING_DIR=$PWD
    pushd ${SRCDIR}
    pushd ${BUILDDIR}
fi
# Install
#^^^^^^^^^
as_root ${MAKE} ${INSTALL_FLAGS} ${INSTALL}
#
# Post-install actions (e.g. install documentation; some configuration)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# All commands in this section will be executed, even for upgrades and
#+reinstalls. To set a command to be executed only once, put it in the
#+Configuration section below.
#
# Leave and delete build directory, unless preservation specified in options
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
popd    # Back to $SRCDIR
popd    # Back to $WORKING_DIR
if ((PRESERVE_BUILD)); then
    num=1
    INC=
    BUILD_STORAGE_DIR=${WORKING_DIR}/${PROG}-${VERSION}-build-${DATE}
    while [ -d ${BUILD_STORAGE_DIR}${INC} ]; do
        INC="-${num}"
        ((num++))
    done
    as_root mv ${BUILDDIR} ${WORKING_DIR}/${PROG}-${VERSION}-build-${DATE}${INC}
fi
as_root rm -rf ${BUILDDIR}
as_root rm -rf ${PKGDIR}
if ! ((RETAIN_DL)); then
    [ -e ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE} ] &&
            as_root rm ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE}
fi
#
# Add to installed list for this computer:
echo "${PROG//-/_}-${VERSION}" >> /list-${CHRISTENED}-${SURNAME}
#
# Stop here unless this is first install
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
((REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Init Script
#*************
if [ "${BOOTSCRIPT}" ]; then
    pushd ${WORKING_DIR}/blfs-bootscripts-${BLFS_BOOTSCRIPTS_VER}
    as_root make install-${BOOTSCRIPT}
    popd
fi
#
###################################################
#
# Configuration
#***************
# This is where we put the main configuration; doesn't get repeated on
#+successive installs or updates unless specified otherwise.
#
###################################################

