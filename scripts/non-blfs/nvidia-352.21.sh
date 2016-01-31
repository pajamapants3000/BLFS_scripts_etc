#!/bin/bash -ev
#
# Installation script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# License: See LICENSE in parent folder
#
# TODO: Override or pass options via command line
# TODO: Clean it up! Make configuration more obvious
# TODO: Separate executable script and package configuration
# TODO: Run sed to fix logfile location as reported in error message
# TODO: Create library to source (functions file) for common tasks
#+     +like checking for the installation of a package, downloading
#+     +and testing checksum, avoiding duplicates and saving old builds, etc.
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
#*************************************************************************
# NOTE: This package does not follow the typical configure-build-install *
#+format, but uses an installer.                                         *
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
# Set kernel version before running! Then unset to avoid future mistakes
# Can also set in environment.
#TGT_KVER=
if ! [ ${TGT_KVER} ]; then
    echo "Please set target kernel version (TGT_KVER) before running"
    exit 1
fi
# May choose one of many different premade config files
XORG_CONF="10-nvidia.conf"
# Just copy the libraries, don't link them
#CPONLY=1
# For CPBIN and CPDAT; the follow options are available
# 0 - Do not copy, no matter what.
# 1 - Copy only if it doesn't involve overwriting existing copies
# 2 - Copy no matter what
# 1 is probably the best/safest choice, except for a full-system upgrade.
CPBIN=1
CPDAT=1
# Uncomment
# Uncomment to keep build files and sources
#PRESERVE_BUILD=1
# Uncomment to build only, do NOT install or modify system
#BUILD_ONLY=1
# Uncomment one to force including or skipping end configuration, resp.
#TREATASNEW=1
#TREATASOLD=1
#
# Name of program, with version and package/archive type
PROG=nvidia
# Alternate program name; in case it doesn't match my conventions;
# My conventions are: no capitals; only '-' between name and version,
#+replace any other '-' with '_'. PROG_ALT fits e.g. download url.
PROG_ALT=NVIDIA-Linux-x86_64
VERSION=352.21
# In this case it's just the extension, not really an archive type.
ARCHIVE=run
# optional suffix of "-no-compat32" depending on which version is needed
if [ $(uname -m) = "x86_64" ]; then
    SUFFIX="-no-compat32"
else
    SUFFIX=
fi
#
# Useful paths
# This is the directory in which we store any downloaded files; by default it
#+is the directory from which this script was executed.
WORKING_DIR=$PWD
# This is where the root of the package directory will be found
PKGDIR=${WORKING_DIR}/${PROG}-${VERSION}${SUFFIX}
# This is where the sources are
SRCDIR=${PKGDIR}
# Source dir build
#BUILDDIR=${SRCDIR}
# Subdirectory build
BUILDDIR=${SRCDIR}/kernel
# Parallel-directory build
#BUILDDIR=${SRCDIR}/../build
# Directory containing this script
SCRIPTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
#
# Downloads; obtain and verify package(s); or specify repo to clone and type
DL_URL=ftp://download.nvidia.com/XFree86/Linux-x86_64
DL_ALT=
MD5=29a88f1538d622cebf751593396053e4
SHASUM=
SHAALG=1
REPO=
# VCS=[git,hg,svn,...]; usually used as VERSION
#VCS=${VERSION}
BRANCH=master
# Prepare sources - PATCHDIR default is in blfs_profile; only specify non-def.
#PATCHDIR=${WORKING_DIR}/patches
PATCH=${PROG}-${VERSION}.patch
if [ ${PATCH} ]; then
    [ -f ${PATCHDIR}/${PATCH} ] ||
        (echo "Patch ${PATCHDIR}/${PATCH} needed but not found" && exit 1)
fi
# Configure; prepare build
PREFICKS=/usr
SYSCONFDER=/etc
LOCALST8DER=/var
MANDER=/usr/share/man
DOCDER=/usr/share/doc/${PROG}-${VERSION}
# CONFIGURE: ${SRCDIR}/configure, cmake, qmake, ./autogen.sh, or other/undefined/blank
CONFIGURE=""
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
CONFIG_FLAGS=""
MAKE="make"
MAKE_FLAGS="SYSSRC=/lib/modules/${TGT_KVER}/build module"
TEST=
TEST_FLAGS="-k"
INSTALL=""
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
    CONFIG_FLAGS="-DCMAKE_INSTALL_PREFIX=${PREFICKS} \
                  -DCMAKE_BUILD_TYPE=Release         \
                  -Wno-dev ${CONFIG_FLAGS} ${CMAKE_SRC_ROOT}"
# configure
#^^^^^^^^^^^
elif [ "x${CONFIGURE:$((${#CONFIGURE}-10)):10}" = "x/configure" ]; then
    [ "${CFG_PREFIX_FLAG}" ]        || CFG_PREFIX_FLAG="--prefix"
    [ "${CFG_SYSCONFDIR_FLAG}" ]    || CFG_SYSCONFDIR_FLAG="--sysconfdir"
    [ "${CFG_LOCALSTATEDIR_FLAG}" ] || CFG_LOCALSTATEDIR_FLAG="--localstatedir"
    [ "${CFG_DOCDIR_FLAG}" ]        || CFG_DOCDIR_FLAG="--docdir"
    [ "${CFG_MANDIR_FLAG}" ]        || CFG_MANDIR_FLAG="--mandir"
    CONFIG_FLAGS="${CFG_PREFIX_FLAG}=${PREFICKS}           \
                  ${CFG_SYSCONFDIR_FLAG}=${SYSCONFDER}     \
                  ${CFG_LOCALSTATEDIR_FLAG}=${LOCALST8DER} \
                  ${CFG_DOCDIR_FLAG}=${DOCDER}             \
                  ${CFG_MANDIR_FLAG}=${MANDER}             \
                  ${CONFIG_FLAGS}"
# Leave place for other possible configuration utilities to set up
# For now, just do-nothing placeholder command
# QMake
#^^^^^^^
elif [ "x${CONFIGURE:$((${#CONFIGURE}-5)):5}" = "xqmake" ]; then
    CONFIG_FLAGS="${CONFIG_FLAGS}"
# Autogen
#^^^^^^^^^
elif [ "x${CONFIGURE:$((${#CONFIGURE}-11)):11}" = "x/autogen.sh" ]; then
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
    if ! [ -f ${PROG}-${VERSION}${SUFFIX}.${ARCHIVE} ]; then
        wget ${DL_URL}/${VERSION}/${PROG_ALT}-${VERSION}${SUFFIX}.${ARCHIVE} \
            -O ${WORKING_DIR}/${PROG}-${VERSION}${SUFFIX}.${ARCHIVE} || FAIL_DL=1
        # FTP/alt Download:
        if (($FAIL_DL)) && [ "$DL_ALT" ]; then
            wget ${DL_ALT}/${VERSION}/${PROG_ALT}-${VERSION}${SUFFIX}.${ARCHIVE} \
            -O ${WORKING_DIR}/${PROG}-${VERSION}${SUFFIX}.${ARCHIVE} &&
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
        echo "${SHASUM}  ${WORKING_DIR}/${PROG}-${VERSION}${SUFFIX}.${ARCHIVE}" |
                shasum -a ${SHAALG} -c ;\
            ( exit ${PIPESTATUS[0]} )
    elif [ "${MD5}" ]; then
        echo "${MD5} ${WORKING_DIR}/${PROG}-${VERSION}${SUFFIX}.${ARCHIVE}" | md5sum -c ;\
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
        as_root mv ${PKGDIR} ${PKGDIR}${INC}
    fi
#
    # Extract package
    #*****************
    chmod u+x ${WORKING_DIR}/${PROG}-${VERSION}${SUFFIX}.${ARCHIVE}
    ${WORKING_DIR}/${PROG}-${VERSION}${SUFFIX}.${ARCHIVE} --extract-only
    mv ${WORKING_DIR}/${PROG_ALT}-${VERSION}${SUFFIX} ${SRCDIR}

fi # End "if [ ${VCS} ]..."
#
# Begin Installation
#********************
# Change to source directory
#^^^^^^^^^^^^^^^^^^^^^^^^^^^
pushd ${SRCDIR}
# Apply patch if necessary
#^^^^^^^^^^^^^^^^^^^^^^^^^^
[ "${PATCH}" ] && patch -Np1 < ${PATCHDIR}/${PATCH}
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
# Build (doesn't apply to this package)
#^^^^^^^
${MAKE} ${MAKE_FLAGS}
pushd uvm
${MAKE} ${MAKE_FLAGS}
mv -v nvidia-uvm.ko ../
popd
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
# Install
#^^^^^^^^^
#if ! ((BUILD_ONLY)); then
#    as_root ${INSTALL} ${INSTALL_FLAGS}
#fi
#
# Post-install actions (e.g. install documentation; some configuration)
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# All commands in this section will be executed, even for upgrades and
#+reinstalls. To set a command to be executed only once, put it in the
#+Configuration section below.
#
# Install kernel module to versioned location
${INSTALL_DIRROOT} ${PREFICKS}/lib/nvidia/${VERSION}/kernel/${TGT_KVER}/modules
${INSTALL_ROOT} ${BUILDDIR}/*.ko \
        ${PREFICKS}/lib/nvidia/${VERSION}/kernel/${TGT_KVER}/modules/
# Symlink kernel module to be used by target kernel
${INSTALL_DIRROOT} /lib/modules/${TGT_KVER}/kernel/drivers/video
ln -sfv ${PREFICKS}/lib/nvidia/${VERSION}/kernel/${TGT_KVER}/modules/*.ko \
        /lib/modules/$TGT_KVER/kernel/drivers/video/
# Copy libraries
${INSTALL_DIRROOT} ${PREFICKS}/lib/nvidia/${VERSION}/xorg/modules/drivers
${INSTALL_DIRROOT} ${PREFICKS}/lib/nvidia/${VERSION}/xorg/modules/extensions
${INSTALL_DIRROOT} ${PREFICKS}/lib/nvidia/${VERSION}/vdpau
for _lib in $(find ${SRCDIR} -name '*.so*'); do
    if [ ${_lib} != "tls_test_dso.so" ]; then
        ${INSTALL_ROOT} ${_lib} ${PREFICKS}/lib/nvidia/${VERSION}/
    fi
done
as_root mv -v ${PREFICKS}/lib/nvidia/${VERSION}/libglx.so.${VERSION} \
              ${PREFICKS}/lib/nvidia/${VERSION}/xorg/modules/extensions/
as_root mv -v ${PREFICKS}/lib/nvidia/${VERSION}/libglx.la \
              ${PREFICKS}/lib/nvidia/${VERSION}/xorg/modules/extensions/
as_root mv -v ${PREFICKS}/lib/nvidia/${VERSION}/nvidia_drv.so \
              ${PREFICKS}/lib/nvidia/${VERSION}/xorg/modules/drivers/
as_root mv -v ${PREFICKS}/lib/nvidia/${VERSION}/libvdpau_nvidia.so.${VERSION} \
              ${PREFICKS}/lib/nvidia/${VERSION}/vdpau
as_root mv -v ${PREFICKS}/lib/nvidia/${VERSION}/libvdpau_trace.so.${VERSION} \
              ${PREFICKS}/lib/nvidia/${VERSION}/vdpau
# Link libraries to put them in use
if ! ((CPONLY)); then
    for _lib in $(find ${PREFICKS}/lib/nvidia/${VERSION} -name '*.so*' |
                  grep -v 'xorg/' | grep -v 'vdpau'); do
        _soname=$(readelf -d "${_lib}" | grep -Po 'SONAME.*: \[\K[^]]*' || true)
        _base=$(echo ${_soname} | sed -r 's/(.*).so.*/\1.so/')
        as_root ln -sfv ${PREFICKS}/lib/nvidia/${VERSION}/${_lib} \
                ${PREFICKS}/lib/_soname
        as_root ln -sfv ${PREFICKS}/lib/_soname ${PREFICKS}/lib/_base
    done
    for _lib in $(find ${PREFICKS}/lib/nvidia/${VERSION}/vdpau -name '*.so*'); do
        _soname=$(readelf -d "${_lib}" | grep -Po 'SONAME.*: \[\K[^]]*' || true)
        _base=$(echo ${_soname} | sed -r 's/(.*).so.*/\1.so/')
        as_root ln -sfv ${PREFICKS}/lib/nvidia/${VERSION}/${_lib} \
                ${PREFICKS}/lib/vdpau/_soname
        as_root ln -sfv ${PREFICKS}/lib/vdpau/_soname ${PREFICKS}/lib/vdpau/_base
    done
    as_root ln -sfv ${PREFICKS}/lib/nvidia/${VERSION}/xorg/modules/extensions/* \
            ${PREFICKS}/lib/xorg/modules/extensions/
    as_root ln -sfv libglx.so.${VERSION} \
            ${PREFICKS}/lib/xorg/modules/extensions/libglx.so.1
    as_root ln -sfv libglx.so.1 \
            ${PREFICKS}/lib/xorg/modules/extensions/libglx.so
    as_root ln -sfv ${PREFICKS}/lib/nvidia/${VERSION}/xorg/modules/drivers/* \
            ${PREFICKS}/lib/xorg/modules/drivers/
fi # if ! ((CPONLY))
# Install binaries
if ((CPBIN)); then
    for _bin in \
                    nvidia-debugdump        \
                    nvidia-xconfig          \
                    nvidia-settings         \
                    nvidia-bug-report.sh    \
                    nvidia-smi              \
                    nvidia-cuda-mps-server  \
                    nvidia-cuda-mps-control \
                    nvidia-modprobe         \
                    nvidia-persistenced     ; do
        if ! ( ((CPBIN==1)) && [ -f ${PREFICKS}/bin/${_bin} ] ); then
            ${INSTALL_BINROOT} ${SRCDIR}/${_bin} ${PREFICKS}/bin/
        fi
    done
fi # if ((CPBIN))
# Install data files
if ((CPDAT)); then
    for _man in \
                    nvidia-xconfig.1.gz          \
                    nvidia-settings.1.gz         \
                    nvidia-smi.1.gz              \
                    nvidia-cuda-mps-control.1.gz \
                    nvidia-modprobe.1.gz         \
                    nvidia-persistenced.1.gz     ; do
        if ! ( ((CPDAT==1)) && [ -f ${MANDER}/man1/${_man} ] ); then
            ${INSTALL_ROOT} ${SRCDIR}/${_man} ${MANDER}/man1/
        fi
    done
    ${INSTALL_ROOT} LICENSE ${PREFICKS}/usr/share/licenses/nvidia/
    for _license in \
                        nvidia-utils  \
                        opencl-nvidia \
                        nvidia-libgl  ; do
        if ! ( ((CPDAT==1)) &&
            [ -f ${PREFICKS}/usr/share/licenses/${_license} ] ); then
            as_root ln -sfv nvidia ${PREFICKS}/usr/share/licenses/${_license}
        fi
    done
    for _doc in \
                        README.txt       \
                        NVIDIA_Changelog ; do
        if ! ( ((CPDAT==1)) && [ -f ${DOCDER}/${_doc} ] ); then
            ${INSTALL_ROOT} ${SRCDIR}/${_doc} ${DOCDER}
        fi
    done
    if ! ( ((CPDAT==1)) && [ -e ${DOCDER}/html ] ); then
        as_root cp -r html ${DOCDER}/
    fi
    as_root ln -sfv ${DOCDER} ${DOCDER}/../nvidia-utils
    ${INSTALL_ROOT} nvidia-settings.desktop ${PREFICKS}/usr/share/applications/
    ${INSTALL_ROOT} nvidia-settings.png ${PREFICKS}/usr/share/pixmaps/
    as_root sed -e 's:__UTILS_PATH__:/usr/bin:' \
                -e 's:__PIXMAP_PATH__:/usr/share/pixmaps:' \
                -i "${pkgdir}/usr/share/applications/nvidia-settings.desktop"
    ${INSTALL_ROOT} nvidia-drm-outputclass.conf \
            ${PREFICKS}/usr/share/X11/xorg.conf.d/
    # OpenCL (?)
    ${INSTALL_DIRROOT} /etc/OpenCL/vendors
    ${INSTALL_ROOT} nvidia.icd /etc/OpenCL/vendors/
fi # if ((CPDAT))
# Copy manpages and other files
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
[ -e ${WORKING_DIR}/${PROG}-${VERSION}${SUFFIX}.${ARCHIVE} ] &&
    as_root rm ${WORKING_DIR}/${PROG}-${VERSION}${SUFFIX}.${ARCHIVE}
#
# Add to installed list for this computer:
if ! ((BUILD_ONLY)); then
    echo "${PROG//-/_}-${VERSION}${SUFFIX}" >> /list-${CHRISTENED}-${SURNAME}
fi
#
# Stop here unless this is first install
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
((REINSTALL)) && exit 0 || (exit 0)
###################################################
#
# Init Script
#*************
if ! ((BUILD_ONLY)) && [ "${BOOTSCRIPT}" ]; then
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
as_root tee -a /etc/modprobe.d/blacklist << "EOF"
blacklist nouveau
EOF
#
if [ -f ${SYSCONFDER}/X11/xorg.conf.d/${XORG_CONF} ]; then
    mv -v ${SYSCONFDER}/X11/xorg.conf.d/${XORG_CONF} \
          ${SYSCONFDER}/X11/xorg.conf.d/${XORG_CONF}.bak
fi
as_root install -v -Dm644 -o root -g root \
    ${BLFSDIR}/files/etc/X11/xorg.conf.d/${XORG_CONF} /etc/X11/xorg.conf.d/
###################################################

