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
# Recommended
#apache-2.4.18
#libxml2-2.9.3
# Optional system utilities and libraries
#aspell-0.60.6.1
#enchant-1.6.0
#libxslt-1.1.28
#an mta (that provides a sendmail command)
#pcre-8.38
#pth-2.0.7
#dmalloc
#net_snmp
#ossp_mm
#re2c
#xmlrpc_epi
# Optional graphics utilities and libraries
#freetype-2.6.3
#libexif-0.6.21
#libjpeg_turbo-1.4.2
#libpng-1.6.21
#libtiff-4.0.6
#x_window_system
#fdf_toolkit
#gd
#t1lib
# Optional web utilities
#curl-7.47.1
#tidy_html5-5.1.25
#caudium
#hyperwave
#mnogosearch
#roxen_webserver
#wddx
# Optional data management utilities and libraries
#db-6.1.26
#mariadb-10.1.11 (or mysql)
#openldap-2.4.44
#postgresql-9.5.1
#sqlite-3.11.0
#unixodbc-2.3.4
#adabas
#birdstep
#cdb
#dbmaker
#empress
#frontbase
#mini sql
#monetra
#qdbm
#
# PHP also provides support for many commercial database tools such as oracle
#+sap and odbc router.
# Optional security/encryption utilities and libraries
#openssl-1.0.2f
#cyrus_sasl-2.1.26
#krb5-1.14
#libmcrypt
#mhash 
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
# 0=mod_php or 1=fastCGI; fastCGI a bit more complicated but faster on
#+heavily loaded servers
MOD_or_fCGI=0
# Docs
SINGLE_HTML=1
MULTI_HTML=1
#** Disable available dependency support **
#DISABLE_SQLITE=1
# Uncomment to keep build files and sources
#PRESERVE_BUILD=1
# Uncomment to build only, do NOT install or modify system
#BUILD_ONLY=1
# Uncomment to install only; skips to the end for already built sources
#INSTALL_ONLY=1
# Retain source downloads
#RETAIN_DL=1
# Uncomment one to force including or skipping end configuration, resp.
#TREATASNEW=1
#TREATASOLD=1
#
# Name of program, with version and package/archive type
PROG=php
# Alternate program name; in case it doesn't match my conventions;
# My conventions are: no capitals; only '-' between name and version,
#+replace any other '-' with '_'. PROG_ALT fits e.g. download url.
PROG_ALT=${PROG}
VERSION=7.0.3
ARCHIVE=tar.xz
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
DL_URL=http://www.php.net/distributions
DL_ALT=
MD5=3c5d2b5b392b78fa92c48822e25ccb56
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
# Documents page
#DL_DOC=http://www.php.net/download-docs.php
DOC_SINGLE_HTML=php_manual_en.html.gz
DOC_MULTI_HTML=php_manual_en.tar.gz
DL_SINGLE_HTML=http://us3.php.net/get/${DOC_SINGLE_HTML}/from/this/mirror
DL_MULTI_HTML=http://us2.php.net/get/${DOC_MULTI_HTML}/from/this/mirror
# Configure; prepare build
PREFICKS=/usr
SYSCONFDER=/etc
#SYSCONFDER=${PREFICKS}/etc
LOCALST8DER=/var
#LOCALST8DER=${PREFICKS}/var
MANDER=${PREFICKS}/share/man
DOCDER=${PREFICKS}/share/doc/${PROG}-${VERSION}
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
# Another common cmake parameter is the build type; defaults to Release or
#+uncomment below
#CBUILDTYPE=RelWithDebInfo
#Specify CMake generator (only if non-standard; will set automatically below)
#CMAKE_GEN='Unix Makefiles'
#
# Pass them in... (these are in addition to the defaults; see below)
CONFIG_FLAGS="${CONFIG_FLAGS} --datadir=/usr/share/php"
if ((MOD_or_fCGI)); then
    CONFIG_FLAGS="${CONFIG_FLAGS} --enable-fpm"
    CONFIG_FLAGS="${CONFIG_FLAGS} --with-fpm-user=apache"
    CONFIG_FLAGS="${CONFIG_FLAGS} --with-fpm-group=apache"
else
    CONFIG_FLAGS="${CONFIG_FLAGS} --with-apxs2=${PREFICKS}/bin/apxs"
fi
CONFIG_FLAGS="${CONFIG_FLAGS} --with-config-file-path=/etc"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-zlib"
CONFIG_FLAGS="${CONFIG_FLAGS} --enable-bcmath"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-bz2"
CONFIG_FLAGS="${CONFIG_FLAGS} --enable-calendar"
CONFIG_FLAGS="${CONFIG_FLAGS} --enable-dba=shared"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-gdbm"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-gmp"
CONFIG_FLAGS="${CONFIG_FLAGS} --enable-ftp"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-gettext"
CONFIG_FLAGS="${CONFIG_FLAGS} --enable-mbstring"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-readline"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-openssl"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-openssl-dir=/usr"
(cat /list-${CHRISTENED}-${SURNAME} | grep "^krb" > /dev/null) &&
        CONFIG_FLAGS="${CONFIG_FLAGS} --with-kerberos" || (exit 0)
(cat /list-${CHRISTENED}-${SURNAME} | grep "^pcre" > /dev/null) &&
CONFIG_FLAGS="${CONFIG_FLAGS} --with-pcre-regex=/usr" || (exit 0)
(cat /list-${CHRISTENED}-${SURNAME} | grep "^curl" > /dev/null) &&
CONFIG_FLAGS="${CONFIG_FLAGS} --with-curl"
# Need special treatment for Berkeley DB 6.X
DBX=$(cat /list-${CHRISTENED}-${SURNAME} | grep -o "^db-[0-9]" > /dev/null)
if [[ $DBX ]]; then
    if [[ ${DBX#db-} == '6' ]]; then
        grep -rl "DB_VERSION_MAJOR == 5" |
            xargs sed -i 's/DB_VERSION_MAJOR == 5/DB_VERSION_MAJOR >= 5/'
        sed -i 's/(4|5)/(4|5|6)/' ext/dba/tests/dba_db4_handlers.phpt
    fi
    CONFIG_FLAGS="${CONFIG_FLAGS} --with-db4"
fi
CONFIG_FLAGS="${CONFIG_FLAGS} --enable-inifile"
CONFIG_FLAGS="${CONFIG_FLAGS} --enable-flatfile"
(cat /list-${CHRISTENED}-${SURNAME} | grep "^libexif" > /dev/null) &&
CONFIG_FLAGS="${CONFIG_FLAGS} --enable-exif"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-gd"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-jpeg-dir=/usr"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-png-dir=/usr"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-zlib-dir=/usr"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-xpm-dir=/usr"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-freetype-dir=/usr"
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^openldap" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} --with-ldap"
    if (cat /list-${CHRISTENED}-${SURNAME} | grep "^cyrus_sasl" > /dev/null); then
        CONFIG_FLAGS="${CONFIG_FLAGS} --with-ldap-sasl"
    fi
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^mariadb" > /dev/null) ||
        (cat /list-${CHRISTENED}-${SURNAME} | grep "^mysql" > /dev/null); then
CONFIG_FLAGS="${CONFIG_FLAGS} --with-mysqli=mysqlnd"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-mysql-sock=/var/run/mysqld/mysqld.sock"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-pdo-mysql"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^unixodbc" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} --with-unixODBC=/usr"
    CONFIG_FLAGS="${CONFIG_FLAGS} --with-pdo-odbc=unixODBC,/usr"
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep "^postgres" > /dev/null); then
    CONFIG_FLAGS="${CONFIG_FLAGS} --with-pgsql"
    CONFIG_FLAGS="${CONFIG_FLAGS} --with-pdo-pgsql"
fi
((DISABLE_SQLITE)) &&
        CONFIG_FLAGS="${CONFIG_FLAGS} --without-pdo-sqlite" || (exit 0)
CONFIG_FLAGS="${CONFIG_FLAGS} --enable-pcntl"
CONFIG_FLAGS="${CONFIG_FLAGS} --with-pspell"
(cat /list-${CHRISTENED}-${SURNAME} | grep "^net_snmp" > /dev/null) &&
        CONFIG_FLAGS="${CONFIG_FLAGS} --with-snmp" || (exit 0)
CONFIG_FLAGS="${CONFIG_FLAGS} --enable-sockets"
(cat /list-${CHRISTENED}-${SURNAME} | grep "^tidy" > /dev/null) &&
CONFIG_FLAGS="${CONFIG_FLAGS} --with-tidy" || (exit 0)
(cat /list-${CHRISTENED}-${SURNAME} | grep "^libxslt" > /dev/null) &&
        CONFIG_FLAGS="${CONFIG_FLAGS} --with-xsl" || (exit 0)
CONFIG_FLAGS="${CONFIG_FLAGS} --with-iconv"

MAKE_FLAGS=""
# a few tests may fail
TEST=test
TEST_FLAGS="-k"
INSTALL="install"
INSTALL_FLAGS=""
#
# Additional/optional configurations: bootscript, group, user, ...
BOOTSCRIPT=php
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
        wget ${DL_URL}/${PROG_ALT}-${VERSION}.${ARCHIVE} \
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
    # Doc downloads
    #***************
    if ((SINGLE_HTML)) && ! [[ -f ${WORKING_DIR}/${DOC_SINGLE_HTML} ]]; then
        wget ${DL_SINGLE_HTML} -O ${WORKING_DIR}/${DOC_SINGLE_HTML}
    fi
    if ((MULTI_HTML)) && ! [[ -f ${WORKING_DIR}/${DOC_MULTI_HTML} ]]; then
        wget ${DL_MULTI_HTML} -O ${WORKING_DIR}/${DOC_MULTI_HTML}
    fi
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
sed -i 's/buffio.h/tidy&/' ${SRCDIR}/ext/tidy/*.c
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
# Tests ask if you want to send fails to the devs; prefix with yes "n" to skip.
if [ "${TEST}" ]; then
    [ -d ${WORKING_DIR}/logs ] || mkdir -v ${WORKING_DIR}/logs
    yes "n" | ${MAKE} ${TEST_FLAGS} ${TEST} 2>&1 | \
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
if ((MOD_or_fCGI)); then
    as_root mv -v ${SYSCONFDER}/php-fpm.conf{.default,}
fi
as_root install -v -m755 -d ${DOCDER}
as_root install -v -m644    CODING_STANDARDS EXTENSIONS INSTALL NEWS README* \
    UPGRADING* php.gif ${DOCDER}
as_root ln -v -sfn \
    ${PREFICKS}/lib/php/doc/Archive_Tar/docs/Archive_Tar.txt ${DOCDER}
as_root ln -v -sfn ${PREFICKS}/lib/php/doc/Structures_Graph/docs ${DOCDER}

# Condensed HTML docs
if ((SINGLE_HTML)); then
    as_root install -v -m644 ${WORKING_DIR}/php_manual_en.html.gz ${DOCDER}
    as_root gunzip -v ${DOCDER}/php_manual_en.html.gz
fi
# Multi-page HTML docs
if ((MULTI_HTML)); then
    as_root tar -xvf ../php_manual_en.tar.gz -C ${DOCDER} --no-same-owner
fi
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
${INSTALL_ROOT} ${SRCDIR}/php.ini-production ${SYSCONFDER}/php.ini
if ((MOD_or_fCGI)); then
    as_root cp -v ${SYSCONFDER}/php-fpm.d/www.conf.default \
            ${SYSCONFDER}/php-fpm.d/www.conf
    sudo sed -i -e '/proxy_module/s/^#//' \
            -e '/proxy_fcgi_module/s/^#//' /etc/httpd/httpd.conf
    as_root tee -a /etc/httpd/httpd.conf << EOF
ProxyPassMatch ^/(.*\.php)$ fcgi://127.0.0.1:9000/srv/www/$1
EOF
else
    sudo sed -i -e '/mpm_event_module/s/^/#/' \
            -e '/mpm_prefork_module/s/^#//' /etc/httpd/httpd.conf
fi
    
#TODO: replace /usr with ${PREFICKS}
#TODO: also, sed doesn't work with as_root for some reason! possibly the way
#+it quotes the command for execution.
sudo sed -i 's@php/includes"@&\ninclude_path = ".:/usr/lib/php"@' \
        ${SYSCONFDER}/php.ini

###################################################

