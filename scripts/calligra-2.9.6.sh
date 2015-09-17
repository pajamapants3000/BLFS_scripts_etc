#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for calligra-2.9.6
#
# NOTE: Installed without issue; calligragemini giving error message saying
#+"installation is broken". But most of the installation seems to work.
#
# Dependencies
#**************
required=
recommended=
optional=
kernel=
#
# Preparation
#*************
source blfs_profile
source setqt4
#
PROG=calligra
VERSION=2.9.6
#TESTCMD="-k check"
DL_URL="http://kde.mirrorcatalogs.com/stable/"
DL_ALT="http://mirrors.mit.edu/kde/stable/"
DL_ADD=
MD5=a576450e8c0ea63b7dff50681a236d61
ARCHIVE="tar.xz"
PREFICKS=/opt/${PROG}-${VERSION}
BOOTSCRIPT=
PROGGROUP=
PROGUSER=
USRCMNT=
CMAKEOPTS="-DCMAKE_INSTALL_PREFIX=${PREFICKS} -DCMAKE_BUILD_TYPE=Release"
CMAKEOPTS="$CMAKEOPTS -Wno-dev"
#
# TODO: make DPDY/DPDN loop parameters over dependencies
#if ! (cat /list-${CHRISTENED}-${SURNAME} | \
#        grep DPDY > /dev/null); then
#    CMAKEOPTS="$CMAKEOPTS -DCMAKE_WITH_DPDY"
#if (cat /list-${CHRISTENED}-${SURNAME} | \
#        grep DPDN > /dev/null); then
#    CMAKEOPTS="$CMAKEOPTS -DCMAKE_WITH_DPDN"
#
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
wget ${DL_URL}/${PROG}-${VERSION}/${PROG}-${VERSION}.${ARCHIVE} \
    -O ${PROG}-${VERSION}.${ARCHIVE} || FAIL_DL=1
# FTP/alt Download:
if (($FAIL_DL)) && [ $DL_ALT ]; then
    wget ${DL_ALT}/${PROG}-${VERSION}/${PROG}-${VERSION}.${ARCHIVE} \
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
# For a x64 NON-multilib system, make sure libs are set up correctly
if [ -L /lib64 -a ! -d ${PREFICKS} ]; then
    as_root mkdir -pv ${PREFICKS}/lib
    as_root ln -sfv ${PREFICKS}/lib ${PREFICKS}/lib64
fi
#
tar -xvf ${PROG}-${VERSION}.${ARCHIVE}
pushd ${PROG}-${VERSION}
sed -i \
    's/gsl_multimin_fminimizer_nmsimplex2/gsl_multimin_fminimizer_nmsimplex/g' \
    krita/image/kis_polygonal_gradient_shape_strategy.cpp \
    krita/plugins/tools/tool_transform2/kis_free_transform_strategy_gsl_helpers.cpp
mkdir -v ../calligra-build
cd       ../calligra-build
cmake $CMAKEOPTS ../${PROG}-${VERSION}
make -j${PARALLEL}
# Test:
# Catch expected failing test and log it
if [ $TESTCMD ]; then
    make ${TESTCMD} 2>&1 | tee ../logs/"$(basename $0)"-log; \
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
as_root make -j${PARALLEL} install
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
    cd blfs-bootscripts-20150823
    as_root make install-${BOOTSCRIPT}
    cd ..
fi
#
###################################################
#
# Configuration
#***************
as_root ln -sv /opt/${PROG}-${VERSION} /opt/${PROG}
as_root install -Dm755 -o root -g root ${BLFSDIR}/files/calligra.sh \
    /etc/profile.d
as_root ln -sfv /etc/profile.d/calligra.sh /etc/profile.d/active/79-calligra.sh
as_root tee -a /etc/ld.so.conf << "EOF"
# Begin Calligra addition
/opt/calligra/lib
# End Calligra
EOF
as_root ldconfig
#
###################################################

