#!/bin/bash
#
# Installer-script generator

PROG=
VERSION=
TEST=
TEST_FLAGS="-k"
ARCHIVE="tar.gz"
MD5=
DL_URL=
DL_ALT=
# This only applies for existing patches in the patch/ folder. Downloaded
#+patches should be applied from PRECFCMDS.
PATCH=
BOOTSCRIPT=
PROGGROUP=
PROGUSER=
USRCMNT=
PREFICKS=/usr
SYSCONFDER=/etc
LOCALST8DER=/var
CONFIG_OPTS=
CONFIGURE="./configure"
MAKE_OPTS=
INSTALL_OPTS=
declare -a VARS=(PROG VERSION TEST TEST_FLAGS ARCHIVE MD5 DL_URL DL_ALT PATCH \
    BOOTSCRIPT PROGGROUP PROGUSER USRCMNT PREFICKS SYSCONFDER LOCALST8DER \
    CONFIG_OPTS CONFIGURE MAKE_OPTS INSTALL_OPTS)
# Arrays

declare -a DL_ADD=()
# These will actually follow the dep name scheme and then be renamed so we
#+can loop them together.
declare -a DL_ADD_DESCR=()
declare -a DL_ADD_CONFIRM=()
declare -a required=()
declare -a recommended=()
declare -a optional=()
declare -a optdoc=()
declare -a runreqrd=()
declare -a runrec=()
declare -a runopt=()
declare -a kernel=()
declare -a PRECFCMDS=()
declare -a PREINSTCMDS=
declare -a POSTINSTCMDS=
#
declare -a ARRAYS=(required recommended optional optdoc runreqrd runrec    \
    runopt kernel confplus_required confplus_recommended confplus_optional \
    confplus_optdoc confplus_runreqrd confplus_runrec confplus_runopt      \
    confminus_required confminus_recommended confminus_optional            \
    confminus_optdoc confminus_runreqrd confminus_runrec confminus_runopt  \
    DL_URL DL_ALT DL_ADD DL_ADD_DESCR DL_ADD_CONFIRM)
#
# Variables set
for var in ${VARS[@]}; do
    echo "Enter value for ${var}"
    echo -n "[$(eval echo \${${var}})]: "
    read input
    if [ ${input} ]; then
        eval "${var}=${input}"
    fi
done
# Arrays set
for deparray in required recommended optional optdoc \
            runreqrd runrec runopt kernel DL_ADD; do
    echo "Enter values for ${deparray}:"
    while read input; do
        if [ x${input} == "x" ]; then break;
        else eval "${deparray}=($(eval echo \${${deparray}[@]}) ${input})"
        fi; done
    unset input
    for index in $(seq 0 $(($(eval echo \${'#'${deparray}})-1))); do
        echo "Enter configure argument to enable support for \
            $(eval echo \${${deparray}[${index}]})"
        echo -n "[NULL]: "
        read input
        if [ ${input} ]; then
            eval "confplus_${deparray}=\
                ($(eval echo \${confplus_${deparray}[@]}) ${input})"
        else
            eval "confplus_${deparray}=\
                ($(eval echo \${confplus_${deparray}[@]}) NULL)"
        fi
        echo "Enter configure argument to disable support for \
            $(eval echo \${${deparray}[${index}]})"
        echo -n "[NULL]: "
        read input
        if [ $input ]; then
            eval "confminus_${deparray}=\
                ($(eval echo \${confminus_${deparray}[@]}) ${input})"
        else
            eval "confminus_${deparray}=\
                ($(eval echo \${confminus_${deparray}[@]}) NULL)"
        fi
    done
done
#
# Substitute parameters
for url in DL_URL DL_ALT; do
    if [ $(eval echo \${${url}}) ]; then
        for subst in PROG VERSION ARCHIVE MD5; do
            match="$(eval echo \${${subst}})"
            repl=${subst}
            eval "${url}=$(eval echo \${${url}//${match}/${repl}})"
        done
        if [ ${url} == "DL_URL" ]; then
            DL_URL=${DL_URL//PROG/\$PROG}
            DL_URL=${DL_URL//VERSION/\$VERSION}
            DL_URL=${DL_URL//ARCHIVE/\$ARCHIVE}
            DL_URL=${DL_URL//MD5/\$MD5}
        elif [ ${url} == "DL_ALT" ]; then
            DL_ALT=${DL_ALT//PROG/\$PROG}
            DL_ALT=${DL_ALT//VERSION/\$VERSION}
            DL_ALT=${DL_ALT//ARCHIVE/\$ARCHIVE}
            DL_ALT=${DL_ALT//MD5/\$MD5}
        fi
        echo "URL becomes $(eval echo \${$url}})"
    fi
done
#
# Create script
[ -r scripts/${PROG}-${VERSION}.sh ] || \
    cp -v installer.skel scripts/${PROG}-${VERSION}.sh
for var in ${VARS[@]}; do
    echo $var
    sed -i "s+^${var}=.*$+${var}=$(eval echo \${${var}})+" \
        scripts/${PROG}-${VERSION}.sh
done
for arr in ${ARRAYS[@]}; do
    echo $arr
    sed -i "s+^${arr}=.*$+${arr}=($(eval echo \${${arr}[@]}))+" \
        scripts/${PROG}-${VERSION}.sh
done
#

