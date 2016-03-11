#!/bin/bash -ev
#
# Installation script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# License: See LICENSE in parent folder
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
#*************
# Begin Required
#yasm-1.3.0
# End Required
# Begin Recommended
#gtk+-2.24.26
#libvdpau-0.9
# End Recommended
# Begin Optional
#cdparanoia-III-10.2
#libdvdread-5.0.2
#libdvdnav-5.0.3
#libdvdcss-1.3.0
#samba-4.1.17
#libbluray
#libcdio
#live555
#rtmpdump
#tivo
#xmms
#alsa-1.0.28
#pulseaudio-5.0
#sdl-1.2.15
#jack
#nas
#openal
#aalib-1.4rc5
#giflib-5.1.1
#libjpeg_turbo-1.4.0
#libmng-2.0.2
#libpng-1.6.16
#openjpeg-1.5.2
#directfb
#libcaca
#svga_lib
#faac-1.28
#faad2-2.7
#lame-3.99.5
#liba52-0.7.4
#libdv-1.0.0
#libmad-0.15.1b
#libmpeg2-0.5.1
#libtheora-1.1.1
#libvpx-1.3.0
#lzo-2.09
#mpg123-1.22.0
#speex-1.2rc2
#xvid-1.3.3
#x264-20141208-2245
#crystalhd
#dirac
#gsm
#ilbc
#libdca
#libnut
#libmpcdec
#opencore
#schroedinger
#tremor
#twolame
#fontconfig-2.11.1
#freetype-2.5.5
#fribidi-0.19.7
#gnutls-3.3.12
#openssl-1.0.2
#opus-1.1
#unrar-5.2.6
#libxslt-1.1.28
#docbook_xml-4.5
#docbook_xsl-1.78.1
#enca
#ladspa
#libbs2b
#lirc
# End Optional
# Begin Kernel
# End Kernel
#
# Options
#********
# Uncomment if GUI is desired - it will install if GTk+-2 is present
#GUI=1
# This verifies presence of GTk.
if ! (cat /list-${CHRISTENED}-${SURNAME} | grep "^XYXY-" > /dev/null); then
    GUI=
fi
#
#
# Preparation
#*************
source ${HOME}/.blfs_profile
# Other common preparations:
#source loadqt4
#pathappend /opt/lxqt/share XDG_DATA_DIRS
#
# Name of program, with version and package/archive type
PROG=mplayer
VERSION=SVN-r37520
ARCHIVE=tar.xz
MD5=db598c845fcc12c917c4cca0d76276e7
SHA1=
#
WORKING_DIR=$PWD
SRCDIR=${WORKING_DIR}/${PROG}-${VERSION}
#
# Downloads; obtain and verify package(s)
DL_URL=http://anduin.linuxfromscratch.org/BLFS/other
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
#SYSCONFDER=/etc                              # not used here
CONFDER=/etc/${PROG}
#LOCALST8DER=/var                            # not used here
#MANDER=/usr/share/man                       # not used here
#DOCDER=/usr/share/doc/${PROG}-${VERSION}    # not used here
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
CONFIG_FLAGS="--enable-dynamic-plugins --enable-menu"
[ ${GUI} ] && CONFIG_FLAGS="${CONFIG_FLAGS} --enable-gui" || (exit 0)
MAKE="make"
MAKE_FLAGS_1=""
MAKE_FLAGS_2="doc"
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
# Standard configuration settings: ./configure, cmake, qmake, ./autogen.sh
if [ "x${CONFIGURE:$((${#CONFIGURE}-5)):5}" = "xcmake" ]; then
    if ((${CMAKE_PARALLEL})); then
        CMAKE_SRC_ROOT=../${PROG}-${VERSION}
    else
        CMAKE_SRC_ROOT=..
    fi
    [ "${CBUILDTYPE}" ] || CBUILDTYPE="Release"
    CONFIG_FLAGS="-DCMAKE_INSTALL_PREFIX=${PREFICKS} \
                  -DCMAKE_BUILD_TYPE=Release         \
                  -Wno-dev ${CONFIG_FLAGS} ${CMAKE_SRC_ROOT}"
elif [ "x${CONFIGURE:$((${#CONFIGURE}-11)):11}" = "x./configure" ]; then
    [ "${CFG_PREFIX_FLAG}" ] || CFG_PREFIX_FLAG="--prefix"
    [ "${CFG_CONFDIR_FLAG}" ] || CFG_CONFDIR_FLAG="--confdir"
    [ "${CFG_LOCALSTATEDIR_FLAG}" ] || CFG_LOCALSTATEDIR_FLAG="--localstatedir"
    CONFIG_FLAGS="${CFG_PREFIX_FLAG}=${PREFICKS}           \
                  ${CFG_CONFDIR_FLAG}=${CONFDER}           \
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
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "^${PROG//-/_}-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ "${PROCEED}" = "yes" ] || [ "${PROCEED}" = "y" ] || exit 0
# Download:
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
    ${VCS} ${VCS_CMD} ${BRANCH_FLAG} ${BRANCH} ${REPO} ${PROG}-${VERSION}
else
    if ! [ -f ${PROG}-${VERSION}.${ARCHIVE} ]; then
        wget ${DL_URL}/${PROG}-${VERSION}.${ARCHIVE} \
            -O ${PROG}-${VERSION}.${ARCHIVE} || FAIL_DL=1
        # FTP/alt Download:
        if (($FAIL_DL)) && [ "$DL_ALT" ]; then
            wget ${DL_ALT}/${PROG}-${VERSION}.${ARCHIVE} \
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
    if [ "${MD5}" ]; then
        echo "${MD5} ${PROG}-${VERSION}.${ARCHIVE}" | md5sum -c ;\
            ( exit ${PIPESTATUS[0]} )
    elif [ "${SHA1}" ]; then
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
[ "${PATCH}" ] && patch -Np1 < ${PATCHDIR}/${PATCH}
#
# Additional downloads
# This skin appears to have been taken off; will need to find another one at
# http://www.mplayerhq.hu/MPlayer/skins/
#if [ ${GUI} ]; then
#    wget http://www.mplayerhq.hu/MPlayer/skins/Clearlooks-1.6.tar.bz2 ||
#        wget ftp://ftp.mplayerhq.hu/MPlayer/skins/Clearlooks-1.6.tar.bz2
#fi
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
sed -i 's:libsmbclient.h:samba-4.0/&:' configure stream/stream_smb.c
if [ "${CONFIGURE}" ]; then
    ${CONFIGURE} ${CONFIG_FLAGS}
fi
#
${MAKE} ${MAKE_FLAGS_1}
${MAKE} ${MAKE_FLAGS_2}
#
# Test:
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
as_root ${MAKE} ${INSTALL_FLAGS} ${INSTALL}
as_root ln -svf ../icons/hicolor/48x48/apps/mplayer.png \
            /usr/share/pixmaps/mplayer.png
# Install HTML docs
as_root install -v -m755 -d /usr/share/doc/mplayer-SVN-r37520
as_root install -v -m644    DOCS/HTML/en/* \
        /usr/share/doc/mplayer-SVN-r37520
#
# Optional configuration; only needed if changes are intended;
as_root install -v -m644 etc/codecs.conf /etc/mplayer
# Regular config file - copy default and change if desired
as_root install -v -m644 etc/*.conf /etc/mplayer
# update icon and desktop database
as_root gtk-update-icon-cache
as_root update-desktop-database
#
# Install skin if GTk GUI was installed
#if [ ${GUI} ]; then
#    as_root tar -xvf  ../Clearlooks-1.6.tar.bz2 \
#            -C    /usr/share/mplayer/skins
#    as_root ln  -sfvn Clearlooks /usr/share/mplayer/skins/default
#fi
#
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
if [ "${BOOTSCRIPT}" ]; then
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

