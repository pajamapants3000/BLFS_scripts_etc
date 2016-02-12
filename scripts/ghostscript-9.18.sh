#!/bin/bash -ev
#
# Installation script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# License: See LICENSE in parent folder
#
# TODO: Override or pass options via command line
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
# Recommended
#freetype-2.6.2
#libjpeg_turbo-1.4.2
#libpng-1.6.19
#libtiff-4.0.6
#little cms-2.7
# Optional
#cairo-1.14.4
#cups-2.1.2
#fontconfig-2.11.1 (required if you are installing any suggested font)
#gtk+-2.24.28
#libidn-1.32
#libpaper-1.1.24+nmu4
#little cms-1.19 (not used by default nor if lcms2 is present or found)
#x_window_system
#
# Options
#********
# Uncomment to keep build files and sources
#PRESERVE_BUILD=1
# Uncomment to build only, do NOT install or modify system
#BUILD_ONLY=1
# Uncomment one to force including or skipping end configuration, resp.
#TREATASNEW=1
#TREATASOLD=1
#
# This will save some space by not linking to the CUPS library if it is present
#NO_CUPS=0
# Uncomment this to skip building the shared library; Only builds if GTK2 is present
#NO_SHARED=1
#
# Install standard fonts
STD_FONT=1
# Install optional fonts
#ALT_FONT=1
#
# Run small test at the end
RUN_TEST=1
#
# Preparation
#*************
source ${HOME}/.blfs_profile
# Other common preparations:
#source loadqt4
#pathappend /opt/lxqt/share XDG_DATA_DIRS
#
# Name of program, with version and package/archive type
PROG=ghostscript
# Alternate program name, possibly with caps, etc.;
#PROG_ALT=
VERSION=9.18
ARCHIVE=tar.bz2
#
# Useful paths
# This is the directory in which we store any downloaded files; by default it
#+is the directory from which this script was executed.
WORKING_DIR=$PWD
# This is where the root of the package directory will be found
PKGDIR=${WORKING_DIR}/${PROG}-${VERSION}
# This is where the sources are
SRCDIR=${PKGDIR}
# Subdirectory build
BUILDDIR=${SRCDIR}/build
# Parallel-directory build
#BUILDDIR=${SRCDIR}/../build
# Directory containing this script
SCRIPTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#
# Downloads; obtain and verify package(s); or specify repo to clone and type
DL_URL=http://downloads.ghostscript.com/public
DL_ALT=
MD5=aa125af368d89b3dbd15fc379f13375f
SHASUM=
SHAALG=1
REPO=
DL_STD_FONT=http://downloads.sourceforge.net/gs-fonts/ghostscript-fonts-std-8.11.tar.gz
MD5_STD_FONT=6865682b095f8c4500c54b285ff05ef6
DL_ALT_FONT=http://downloads.sourceforge.net/gs-fonts/gnu-gs-fonts-other-6.0.tar.gz
MD5_ALT_FONT=33457d3f37de7ef03d2eea05a9e6aa4f
# VCS=[git,hg,svn,...]; usually used as VERSION
#VCS=${VERSION}
BRANCH=master
# Prepare sources - PATCHDIR default is in blfs_profile; only specify non-def.
#PATCHDIR=${WORKING_DIR}/patches
#PATCH=${PROG}-${VERSION}.patch
# Configure; prepare build
PREFICKS=/usr
SYSCONFDER=/etc
LOCALST8DER=/var
MANDER=/usr/share/man
DOCDER=/usr/share/doc/${PROG}-${VERSION}
# CONFIGURE: ${SRCDIR}/configure, cmake, qmake, ./autogen.sh, or other/undefined/blank
CONFIGURE="${SRCDIR}/configure"
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
#
# Another common cmake parameter is the build type; defaults to Release or
#+uncomment below
#CBUILDTYPE=RelWithDebInfo
#
#Specify CMake generator
#CMAKE_GEN='Unix Makefiles'
#
# Pass them in... (these are in addition to the defaults; see below)
CONFIG_FLAGS="--disable-compile-inits --enable-dynamic"
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^libtiff-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} --with-system-libtiff"
fi
((NO_CUPS)) && CONFIG_FLAGS="${CONFIG_FLAGS} --disable-cups"
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
PROGGROUPNUM=
PROGUSER=
PROGUSERNUM=${PROGGROUPNUM}
USRCMNT=
#
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
    CONFIG_FLAGS="-DCMAKE_INSTALL_PREFIX=${PREFICKS} \
                  -DCMAKE_BUILD_TYPE=Release         \
                  -Wno-dev ${CONFIG_FLAGS} ${CMAKE_SRC_ROOT}"
# configure
#^^^^^^^^^^^
elif [ "x${CONFIGURE:$((${#CONFIGURE}-10)):10}" = "x/configure" ]; then
    [ "${CFG_PREFIX_FLAG}" ]        || CFG_PREFIX_FLAG="--prefix"
    [ "${CFG_SYSCONFDIR_FLAG}" ]    || CFG_SYSCONFDIR_FLAG="--sysconfdir"
    [ "${CFG_LOCALSTATEDIR_FLAG}" ] || CFG_LOCALSTATEDIR_FLAG="--localstatedir"
    CONFIG_FLAGS="${CFG_PREFIX_FLAG}=${PREFICKS}           \
                  ${CFG_SYSCONFDIR_FLAG}=${SYSCONFDER}     \
                  ${CFG_LOCALSTATEDIR_FLAG}=${LOCALST8DER} \
                  ${CONFIG_FLAGS}"
# Leave place for other possible configuration utilities to set up
# For now, just do-nothing placeholder command
# QMake
#^^^^^^^
elif [ "x${CONFIGURE:$((${#CONFIGURE}-5)):5}" = "xqmake" ]; then
    CONFIG_FLAGS="${CONFIG_FLAGS}"
# Autogen
#^^^^^^^^^
elif [ "x${CONFIGURE:$((${#CONFIGURE}-12)):12}" = "x./autogen.sh" ]; then
    CONFIG_FLAGS="${CONFIG_FLAGS}"
# Default
#^^^^^^^^^
else
    CONFIG_FLAGS="${CONFIG_FLAGS}"
fi
#
# Default make flags
#********************
MAKE_FLAGS="   -j${PARALLEL} ${MAKE_FLAGS}"
TEST_FLAGS="   -j${PARALLEL} ${TEST_FLAGS}"
INSTALL_FLAGS="-j${PARALLEL} ${INSTALL_FLAGS}"
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
# Obtain package
#****************
if [ "${VCS}" ]; then
    if [ "${VCS}" == "git" -o ${VCS} == "hg" ]; then
        VCS_CMD="clone"
        BRANCH_FLAG="-b"
    elif [ "${VCS}" == "svn" ]; then
        VCS_CMD="co"
        BRANCH_FLAG=
    else
        echo "error: unkown value for VCS; aborting."
        exit 1
    fi
#
    # Preserve any previous builds; Ensure empty target directory
    #*************************************************************
    num=1
    while [ -d ${PKGDIR}${INC} ]; do
        INC="-${num}"
        ((num++))
    done
    if [ ${num} -gt 1 ]; then
        if ((INC)); then
            as_root mv ${PKGDIR} ${PKGDIR}${INC}
        fi
    fi
#
    # Clone Repository
    #******************
    ${VCS} ${VCS_CMD} ${BRANCH_FLAG} ${BRANCH} ${REPO} ${PKGDIR}
#
else
    # Download Package
    #******************
    if ! [ -f ${PROG}-${VERSION}.${ARCHIVE} ]; then
        wget ${DL_URL}/${PROG}-${VERSION}.${ARCHIVE} \
            -O ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE} || FAIL_DL=1
        # FTP/alt Download:
        if (($FAIL_DL)) && [ "$DL_ALT" ]; then
            wget ${DL_ALT}/${PROG}-${VERSION}.${ARCHIVE} \
            -O ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE} || FAIL_DL=2
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
    while [ -d ${PKGDIR}${INC} ]; do
        INC="-${num}"
        ((num++))
    done
    if [ ${num} -gt 1 ]; then
        if ((INC)); then
            as_root mv ${PKGDIR} ${PKGDIR}${INC}
        fi
    fi
#
    # Extract package
    #*****************
    mkdir -v ${PKGDIR}
    tar -xf ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE} \
            -C ${PKGDIR} --strip-components=1
fi # End "if [ ${VCS} ]..."
#
# Additional Downloads
((STD_FONT)) &&
if ! [ -f ghostscript-fonts-std-8.11.tar.gz ]; then
    wget ${DL_STD_FONT} -O ${WORKING_DIR}/ghostscript-fonts-std-8.11.tar.gz
    echo "${MD5_STD_FONT} ${WORKING_DIR}/ghostscript-fonts-std-8.11.tar.gz" | md5sum -c ;\
        ( exit ${PIPESTATUS[0]} )
fi
((ALT_FONT)) &&
if ! [ -f gnu-gs-fonts-other-6.0.tar.gz ]; then
    wget ${DL_ALT_FONT} -O ${WORKING_DIR}/gnu-gs-fonts-other-6.0.tar.gz
    echo "${MD5_ALT_FONT} ${WORKING_DIR}/gnu-gs-fonts-other-6.0.tar.gz" | md5sum -c ;\
        ( exit ${PIPESTATUS[0]} )
fi
# Begin Installation
#********************
# Change to source directory
#^^^^^^^^^^^^^^^^^^^^^^^^^^^
pushd ${SRCDIR}
# Apply patch if necessary
#^^^^^^^^^^^^^^^^^^^^^^^^^^
[ "${PATCH}" ] && patch -Np1 < ${PATCHDIR}/${PATCH}
#
for lib in freetype libpng; do
    if (cat /list-${CHRISTENED}-${SURNAME} | grep "^${lib}-" > /dev/null); then
        GOT_LIBS="${GOT_LIBS} ${lib}"
    fi
done
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^little_cms-" > /dev/null); then
    GOT_LIBS="${GOT_LIBS} lcms2"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^libjpeg_turbo-" > /dev/null); then
    GOT_LIBS="${GOT_LIBS} jpeg"
fi
sed -i 's/ZLIBDIR=src/ZLIBDIR=$includedir/' configure.ac configure &&
rm -rf ${GOT_LIBS} zlib
#
# Create build directory
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
mkdir -v ${BUILDDIR}
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
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^gtk+-2" > /dev/null); then
    ((NO_SHARED)) || make so
fi
# Test (optional)
#^^^^^^^^^^^^^^^^^
if [ "${TEST}" ]; then
    [ -d ${WORKING_DIR}/logs ] || mkdir -v ${WORKING_DIR}/logs
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
# Install
#^^^^^^^^^
if ! ((BUILD_ONLY)); then
    as_root ${MAKE} ${INSTALL_FLAGS} ${INSTALL}
fi
#
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^gtk+-2" > /dev/null) &&
        ! ((NO_SHARED)); then
    as_root make soinstall
    as_root install -v -m644 ${SRCDIR}/base/*.h /usr/include/ghostscript
    as_root ln -v -s ghostscript /usr/include/ps
fi
# Post-install actions (e.g. install documentation; some configuration)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# All commands in this section will be executed, even for upgrades and
#+reinstalls. To set a command to be executed only once, put it in the
#+Configuration section below.
#
as_root ln -sfvn ../${PROG}/${VERSION}/doc /usr/share/doc/${PROG}-${VERSION}
#
((STD_FONT)) &&
    as_root tar -xvf ${WORKING_DIR}/ghostscript-fonts-std-8.11.tar.gz -C /usr/share/ghostscript --no-same-owner &&
    as_root fc-cache -v /usr/share/ghostscript/fonts/
((ALT_FONT)) &&
    as_root tar -xvf ${WORKING_DIR}/gnu-gs-fonts-other-6.0.tar.gz -C /usr/share/ghostscript --no-same-owner &&
    as_root fc-cache -v /usr/share/ghostscript/fonts/
#
# Just a little test
gs -q -dBATCH /usr/share/${PROG}/${VERSION}/examples/tiger.eps
# Leave and delete build directory, unless preservation specified in options
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
popd    # Back to $SRCDIR
popd    # Back to $WORKING_DIR
if ! ((PRESERVE_BUILD)) && ! ((BUILD_ONLY)); then
    as_root rm -rf ${BUILDDIR}
else
    as_root mv ${BUILDDIR} ${WORKING_DIR}/${PROG}-${VERSION}-build-${DATE}
fi
as_root rm -rf ${PKGDIR}
[ -e ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE} ] &&
    as_root rm ${WORKING_DIR}/${PROG}-${VERSION}.${ARCHIVE}
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
    pushd ${BLFSDIR}/blfs-bootscripts-${BLFS_BOOTSCRIPTS_VER}
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

