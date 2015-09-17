#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for XYXY
DATE=$(date +%Y%m%d)
TIME=$(date +%H%M%S)
#
# If executed with command line options, then instead of running installer
#+the arguments should be used to modify the variables.
if [ ${#} -gt 1 ]; then
    sed -i "s:^${1}=.*$:${1}=${2}:" $(readlink -nf $BASH_SOURCE)
    exit 0
fi
# ToDo:
# versioniong on dependencies; not sure how I want to go about that yet.
# Dependencies
#**************
declare -a required=()
declare -a recommended=()
declare -a optional=()
declare -a optdoc=()
declare -a runreqrd=()
declare -a runrec=()
declare -a runopt=()
declare -a kernel=()
# ?arrays of version
declare -a verrequired=()
declare -a verrecommended=()
declare -a veroptional=()
declare -a veroptdoc=()
declare -a verrunreqrd=()
declare -a verrunrec=()
declare -a verrunopt=()
declare -a verkernel=()
# Add functionality
declare -a confplus_required=()
declare -a confplus_recommended=()
declare -a confplus_optional=()
declare -a confplus_optdoc=()
declare -a confplus_runreqrd=()
declare -a confplus_runrec=()
declare -a confplus_runopt=()
declare -a confplus_kernel=()
# Remove functionality
declare -a confminus_required=()
declare -a confminus_recommended=()
declare -a confminus_optional=()
declare -a confminus_optdoc=()
declare -a confminus_runreqrd=()
declare -a confminus_runrec=()
declare -a confminus_runopt=()
declare -a confminus_kernel=()
#
required=()
recommended=()
optional=()
optdoc=()
runreqrd=()
runrec=()
runopt=()
kernel=()
verrequired=()
verrecommended=()
veroptional=()
veroptdoc=()
verrunreqrd=()
verrunrec=()
verrunopt=()
verkernel=()
confplus_required=()
confplus_recommended=()
confplus_optional=()
confplus_optdoc=()
confplus_runreqrd=()
confplus_runrec=()
confplus_runopt=()
confplus_kernel=()
confminus_required=()
confminus_recommended=()
confminus_optional=()
confminus_optdoc=()
confminus_runreqrd=()
confminus_runrec=()
confminus_runopt=()
confminus_kernel=()
# Preparation
#*************
source blfs_profile
#
# For packages that don't support or do well with parallel build
#PARALLEL=1
#
# Name of program, with version and package/archive type
PROG=tester
VERSION=1.2.3
ARCHIVE=tar.gz
#
WORKING_DIR=$PWD
SRCDIR=${WORKING_DIR}/${PROG}-${VERSION}
#
# Downloads; obtain and verify package(s)
DL_URL=http://www.place.org/$PROG/$VERSION/$PROG-$VERSION.$ARCHIVE
DL_ALT=
declare -a DL_ADD=()
declare -a DL_ADD_DESCR=()
declare -a DL_ADD_CONFIRM=()
DL_ADD=()
DL_ADD_DESCR=()
DL_ADD_CONFIRM=()
MD5=md5sumtest
# Prepare sources
PATCHDIR=${WORKING_DIR}/patches
PATCH=
# PRECFCMDS and other command arrays: Make sure to use single quotes or
#+escape the spaces that don't separate elements!
declare -a PRECFCMDS=()
PRECFCMDS=()
# Configure; prepare build
PREFICKS=/usr
SYSCONFDER=/etc
LOCALST8DER=/var
# CONFIGURE: cmake, qmake, "./autogen.sh", or undefined
CONFIGURE=./configure
# Default flags
CONFIG_FLAGS=
# User-defined flags
CONFIG_OPTS=
if [ x${CONFIGURE} == 'x./configure' ]; then
    PREFICKS_FLAG="--prefix"
    SYSCONFDER_FLAG="--sysconfdir"
    LOCALST8DER_FLAG="--localstatedir"
    CONFIG_FLAGS="${PREFICKS_FLAG}=${PREFICKS}      \
                  ${SYSCONFDER_FLAG}=${SYSCONFDER}  \
                  ${LOCALST8DER_FLAG}=${LOCALST8DER}"
elif [ x${CONFIGURE} == 'xcmake' ]; then
    PREFICKS_FLAG="-DCMAKE_INSTALL_PREFIX"
    CONFIG_FLAGS="${PREFICKS_FLAG}=${PREFICKS} \
                  -DCMAKE_BUILD_TYPE=Release   \
                  -Wno-dev ${CMAKE_SRC_ROOT}"
elif [ x${PREMAKE} == "xqmake" ]; then
    QMAKESPEC=
    CONFIG_FLAGS="${QMAKESPEC}"
fi
#
MAKE="make"
MAKE_FLAGS="-j${PARALLEL}"
MAKE_OPTS=
TESTCMD=
TEST_FLAGS=
declare -a PREINSTCMDS=()
PREINSTCMDS=()
INSTALL="install"
INSTALL_FLAGS=
INSTALL_OPTS=
# These are typically done as root, but there are variations so I will
#+include "as_root" or whatever in the command itself.
declare -a POSTINSTCMDS=
POSTINSTCMDS=()
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
# Add configure options based on dependencies present
for deparray in required recommended optional optdoc runreqrd runrec runopt; do
    for index in $(seq 0 $(($(eval echo \${#${deparray}})-1))); do
        if (cat /list-${CHRISTENED}-${SURNAME} | \
            grep $(eval echo \${${deparray}[${index}]}) > /dev/null); then
            if ! [ $(eval echo \${confplus_${deparray}[${index}]}) == "NULL" ]; then
                CONFARGS="${CONFARGS} $(eval echo \${confplus_${deparray}[${index}]})"
            fi
        else
            if ! [ $(eval echo \${confminus_${deparray}[${index}]}) == "NULL" ]; then
                CONFARGS="${CONFARGS} $(eval echo \${confminus_${deparray}[${index}]})"
            fi
        fi
    done
done
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
elif [ $PROGUSER ]; then
    pathappend /usr/sbin
    if ! (cat /etc/passwd | grep $PROGUSER > /dev/null); then
    as_root useradd -c "${USRCMNT}" -d /var/run/dbus \
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
grep ${PROG}"-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
# If this fails, we exit unless we have a DL_ALT to try
DLFAIL=0
#wget ${DL_URL}/${PROG}-${VERSION}.${ARCHIVE} || [ $DL_ALT ] && DLFAIL=1
wget ${DL_URL} || [ $DL_ALT ] && DLFAIL=1
# FTP/alt Download:
if (($DLFAIL)) && [ $DL_ALT ]; then
#    wget ${DL_ALT}/${PROG}-${VERSION}.${ARCHIVE}
    wget ${DL_ALT}
#
# md5sum:
echo "${MD5} ${PROG}-${VERSION}.${ARCHIVE}" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf ${PROG}-${VERSION}.${ARCHIVE}
pushd ${PROG}-${VERSION}
[ ${PATCH} ] && patch -Np1 < ${PATCHDIR}/${PATCH}
for precfcmd in ${PRECFCMDS[@]}; do
    eval "${precfcmd}"
done
${CONFIGURE} ${CONFIG_FLAGS} ${CONFIG_OPTS}
${MAKE} ${MAKE_FLAGS} ${MAKE_OPTS}
# Test:
# Catch expected failing test and log it
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
for preinstcmd in ${PREINSTCMDS[@]}; do
    eval "${preinstcmd}"
done
as_root ${MAKE} ${INSTALL_FLAGS} ${INSTALL_OPTS} ${INSTALL}
for postinstcmd in ${POSTINSTCMDS[@]}; do
    eval "${postinstcmd}"
done
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
