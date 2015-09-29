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
#
# This script relies on the presence of lua-5.1! NOT Lua-5.3, not Lua-5.0,...
#+you get the idea. liblua5.1.a should be installed in /usr/lib/, and
#+the headers should be in /usr/include/lua5.1 with unversioned names.
#   THIS WORKS!
#
# The biggest bitch dependency was tolua++, which is like a decade old and
#+not maintained for the last five years at least.
#
# Note: Both Lua5.1 and tolua++ had to be compiled with -fPIC. Not exactly
#+sure if there are any consequence of this; Generates Position Independent
#+Code, important for shared objects/libraries. Why don't I use this more?
#
# I spent so much time getting this right that I don't feel like writing out
#+a complete listing of dependencies. Look at the options, most of the deps
#+are optional and obvious from the existing flags, most of which are in
#+this script. (possibly all of them! another thing I should do is verify
#+this; another time perhaps.)
#
# Options
#
# Ok, this guy is LOADED with options! Best way to go is probably to do this
#+manually with ccmake instead of cmake, but I will try to make a good
#+automation here.
# Options that may vary and are hard to automate:
# BUILD_EVE - EVE online
# BUILD_IBM - IBM/Lenovo Notebooks
#B_IBM=OFF
# BUILD_NVIDIA - nVidia Support
#B_NV=OFF
# BUILD_WLAN
#B_W=OFF
# BUILD_XSHAPE - ?
#
# Preparation
#*************
source blfs_profile
# Other common preparations:
#source loadqt4
#pathappend /opt/lxqt/share XDG_DATA_DIRS
#
# Name of program, with version and package/archive type
PROG=conky
VERSION=1.10.0
ARCHIVE=tar.gz
MD5=cdc0298e5f257829d574ae8114170d9b
#
WORKING_DIR=$PWD
SRCDIR=${WORKING_DIR}/${PROG}-${VERSION}
#
# Downloads; obtain and verify package(s)
DL_URL=https://github.com/brndnmtthws
DL_ALT=
REPO=
# VCS=[git,hg,svn,...]
VCS=
BRANCH=master
# Prepare sources
#PATCHDIR=${WORKING_DIR}/patches
PATCH=${PROG}-${VERSION}.patch
# Configure; prepare build
PREFICKS=/usr
SYSCONFDER=/etc
LOCALST8DER=/var
MANDER=/usr/share/man
DOCDER=/usr/share/doc/${PROG}-${VERSION}
# CONFIGURE: ./configure, cmake, qmake, ./autogen.sh, or other/undefined
CONFIGURE="cmake"
#
# Flags
# -j${PARALLEL} included by default; uncomment this to unset.
#PARALLEL=1
# Default for cmake is to build in build subdirectory, but some programs
#+demand building in a directory that is paralleli to (a sibling of) source.
#CMAKE_PARALLEL=1
#
# These should work ok as defaults
CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_ICONV=ON"
CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_OLD_CONFIG=OFF"
CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_BUILTIN_CONFIG=OFF"
CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_WEATHER_METAR=ON -DBUILD_WEATHER_XOAP=ON"
CONFIG_FLAGS="${CONFIG_FLAGS} -DDEFAULTNETDEV=${IFACE}"
CONFIG_FLAGS="${CONFIG_FLAGS} -DLOCALE_DIR=${PREFICKS}/share/locale"
CONFIG_FLAGS="${CONFIG_FLAGS} -DPACKAGE_LIBRARY_DIR=${PREFICKS}/lib/conky"
CONFIG_FLAGS="${CONFIG_FLAGS} -DLUA_LIBRARIES=lua5.1;dl;m"
CONFIG_FLAGS="${CONFIG_FLAGS} -DLUA_INCLUDE_DIRS='/usr/include/lua5.1'"
# Can be manually set above; if not, take best guess
[ ${B_IBM} ] || if [ ${CHRISTENED}} = "Selene" ]; then
    B_IBM="ON"
else
    B_IBM="OFF"
fi
[ ${B_NV} ] ||
        if (cat /list-${CHRISTENED}-${SURNAME} | grep "^nvidia-" > /dev/null); then
    B_NV="ON"
else
    B_NV="OFF"
fi
[ ${B_W} ] ||
        if (cat /list-${CHRISTENED}-${SURNAME} | \
                grep "^wpa_supplicant-" > /dev/null); then
    B_W="ON"
else
    B_W="OFF"
fi
        if (cat /list-${CHRISTENED}-${SURNAME} | grep "^curl-" > /dev/null); then
CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_IBM=${B_IBM}"
CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_NVIDIA=${B_NV}"
CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_WLAN=${B_W}"
# Add support as necessary (an associative array would be nice here!)
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^curl-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_CURL=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^libical-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_ICAL=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^imlib2-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_IMLIB2=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^audacious-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_AUDACIOUS=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^bmpx-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_BMPX=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^cmus-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_CMUS=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^eve-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_EVE=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^moc-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_MOC=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^mpd-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_MPD=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^mysql-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_MYSQL=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^xmms2-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_XMMS2=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^libircclient-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_IRC=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^libmicrohttpd-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_HTTP=ON"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^lua-" > /dev/null); then
#if ((0)); then
    if (cat /list-${CHRISTENED}-${SURNAME} | grep "^cairo-" > /dev/null); then
        CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_LUA_CAIRO=ON"
    fi
    if (cat /list-${CHRISTENED}-${SURNAME} | grep "^imlib2-" > /dev/null); then
        CONFIG_FLAGS="${CONFIG_FLAGS} -DBUILD_LUA_IMLIB2=ON"
    fi
fi
#
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
# Standard configuration settings: ./configure, cmake, qmake, ./autogen.sh
if [ "x${CONFIGURE:$((${#CONFIGURE}-5)):5}" = "xcmake" ]; then
    if ((${CMAKE_PARALLEL})); then
        CMAKE_SRC_ROOT=../${PROG}-${VERSION}
    else
        CMAKE_SRC_ROOT=..
    fi
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
if [ ${PROGGROUP} ]; then
    if ! (cat /etc/group | grep ${PROGGROUP} > /dev/null); then
        pathappend /usr/sbin
        as_root groupadd -g ${PROGGROUPNUM} ${PROGGROUP}
    fi
    if [ ${PROGUSER} ]; then
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
        wget ${DL_URL}/${PROG}/archive/v${VERSION}.${ARCHIVE} \
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
    tar -xf ${PROG}-${VERSION}.${ARCHIVE} -C ${PROG}-${VERSION} --strip-components=1
fi # End "if [ ${VCS} ]..."
#
pushd ${PROG}-${VERSION}
[ ${PATCH} ] && patch -Np1 < ${PATCHDIR}/${PATCH}
#
##cmake child build
mkdir -v build && cd build
##cmake parabuild
#mkdir ../{PROG}-build && cd ../${PROG}-build
##autogen first
#./autogen.sh
#
if [ ${CONFIGURE} ]; then
    ${CONFIGURE} ${CONFIG_FLAGS}
fi
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
cd ..
[ -d ${HOME}/.config/conky ] || mkdir ${HOME}/.config/conky
cp -v data/*.conf ${HOME}/.config/conky/
[ -f ${HOME}/.conkyrc ] && mv -v ${HOME}/.conkyrc ${HOME}/.conkyrc.bak || (exit 0)
ln -sfv .config/conky/conky.conf ${HOME}/.conkyrc
## Extra vim filetype detection and syntax plugins for conkyrc
for dir in ftdetect syntax; do
    [ -d ${HOME}/.vim/${dir} ] || mkdir -pv ${HOME}/.vim/${dir}
    cp -v extras/vim/${dir}/conkyrc.vim ${HOME}/.vim/${dir}/
done
##
## nano syntax coloring for conkyrc
[ -d ${HOME}/.config/nano ] || mkdir -pv ${HOME}/.config/nano
cp extras/nano/conky.nanorc ${HOME}/.config/nano/
##
popd
#as_root rm -rf ${PROG}-${VERSION}
##cmake parabuild
#as_root rm -rf ${PROG}-build
#
# Add to installed list for this computer:
#echo "${PROG//-/_}-${VERSION}" >> /list-${CHRISTENED}-${SURNAME}
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


