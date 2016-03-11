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
# Note: if /usr is on a separate partition and you need zsh to be available
#+during boot, you need to either move libpcre and libgdbm to /lib and create
#+symlinks so they can still be found in /usr/lib, or else link them statically
#+(or build without support for them!) To link statically you need to modify
#+config.modules after running configure. (Why can't you just pass
#+--enable-static or something?)
# The relevant lines in config.modules are:
#name=zsh/db/gdbm modfile=Src/Modules/db_gdbm.mdd link=dynamic auto=yes load=no
#name=zsh/pcre modfile=Src/Modules/pcre.mdd link=no auto=yes load=no
# Not sure if any other modules need to be made static as well...?
# We would apply the following sed commands after configuring:
#sed -i "s/\(db_gdbm.mdd link\)=dynamic/\1=sgdbm.mddtatic/" config.modules
#sed -i "s/\(pcre.mdd link\)=dynamic/\1=static/"    config.modules
# OR.... uncomment this to move the libraries to /lib and symlink in /usr/lib
#PARTITIONED=1
#
# Preparation
#*************
source ${HOME}/.blfs_profile
# Other common preparations:
#source loadqt4
#pathappend /opt/lxqt/share XDG_DATA_DIRS
#
# Set to 0 or comment out to skip optional documentation download
DL_DOC=1
#
#Optional deps
#libcap-2.24
#pcre-8.38
#valgrind-3.11.0
#
# For packages that don't support or do well with parallel build
#PARALLEL=1
#
# Name of program, with version and package/archive type
PROG=zsh
VERSION=5.2
ARCHIVE=tar.xz
MD5=afe96fde08b70e23c1cab1ca7a68fb34
MD5_DOC=873f1ade1fa5d0d15f9cba16d3ba5f98
#
WORKING_DIR=$PWD
SRCDIR=${WORKING_DIR}/${PROG}-${VERSION}
#
# Downloads; obtain and verify package(s)
DL_URL=http://www.zsh.org/pub
DL_ALT=
# Prepare sources
PATCHDIR=${WORKING_DIR}/patches
PATCH=
# Configure; prepare build
PREFICKS=/usr
SYSCONFDER=/etc/${PROG}
LOCALST8DER=/var
# CONFIGURE: ./configure, cmake, qmake, ./autogen.sh, or other/undefined
CONFIGURE="./configure"
#
# Flags
# -j${PARALLEL} included by default; uncomment line above to unset.
# Place zsh binaries in root filesystem instead of /usr/bin
CONFIG_FLAGS="${CONFIG_FLAGS} --bindir=/bin --enable-etcdir=/etc/zsh"
# Consolidate configuration files in /etc/zsh instead of conventional /etc
#+or /usr/etc
SYSCONFDIR=/etc/zsh
CONFIG_FLAGS="${CONFIG_FLAGS} --enable-etcdir=/etc/zsh"
# Include pcre support
if (cat /list-${CHRISTENED}-${SURNAME} | \
        grep "pcre-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} --enable-pcre"
fi
# Include libcap support
if (cat /list-${CHRISTENED}-${SURNAME} | \
        grep "libcap-" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} --enable-cap"
fi
# Disable gdbm support (apparently this alters the license applied to the
#+resulting binary - it will be under GPL instead of...? Something more
#+"free"?)
#CONFIG_FLAGS="${CONFIG_FLAGS} --disable-gdbm"
#
MAKE="make"
MAKE_FLAGS=""
TEST=check
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
grep "${PROG//-/_}-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
if ! [ -f ${PROG}-${VERSION}.${ARCHIVE} ]; then
    wget ${DL_URL}/${PROG}-${VERSION}.${ARCHIVE} \
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
# Additional Download
if ((${DL_DOC})); then
    wget ${DL_URL}/${PROG}-${VERSION}-doc.${ARCHIVE}
    # md5sum:
    echo "${MD5_DOC} ${PROG}-${VERSION}-doc.${ARCHIVE}" | md5sum -c ;\
        ( exit ${PIPESTATUS[0]} )
fi
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
pushd ${PROG}-${VERSION}
if ((${DL_DOC})); then
    tar --strip-components=1 -xvf ../${PROG}-${VERSION}-doc.${ARCHIVE}
fi
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
makeinfo  Doc/zsh.texi --plaintext -o Doc/zsh.txt
makeinfo  Doc/zsh.texi --html      -o Doc/html
makeinfo  Doc/zsh.texi --html --no-split --no-headers -o Doc/zsh.html
#
# with texlive, can build pdf version of docs
if (cat /list-${CHRISTENED}-${SURNAME} | \
        grep "texlive-" > /dev/null); then
    texi2pdf  Doc/zsh.texi -o Doc/zsh.pdf
fi
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
as_root make infodir=/usr/share/info install.info
as_root install -v -m755 -d                 /usr/share/doc/${PROG}-${VERSION}/html
as_root install -v -m644 Doc/html/*         /usr/share/doc/${PROG}-${VERSION}/html
as_root install -v -m644 Doc/zsh.{html,txt} /usr/share/doc/${PROG}-${VERSION}
#
if ((DL_DOC)); then
    as_root make htmldir=/usr/share/doc/${PROG}-${VERSION}/html install.html
    as_root install -v -m644 Doc/zsh.dvi /usr/share/doc/${PROG}-${VERSION}
fi
#
if (cat /list-${CHRISTENED}-${SURNAME} | \
        grep "texlive-" > /dev/null); then
    install -v -m644 Doc/zsh.pdf /usr/share/doc/${PROG}-${VERSION}
fi
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
if ((PARTITIONED)); then
    as_root mv -v /usr/lib/libpcre.so.* /lib
    as_root ln -v -sf ../../lib/libpcre.so.0 /usr/lib/libpcre.so
    as_root mv -v /usr/lib/libgdbm.so.* /lib
    as_root ln -v -sf ../../lib/libgdbm.so.3 /usr/lib/libgdbm.so
fi
#
as_root tee -a /etc/shells << "EOF"
/bin/zsh
EOF
#
###################################################

