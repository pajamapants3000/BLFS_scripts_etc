#!/bin/bash
#
# This is the skeleton file for program installers. genscript.sh copies and
#+fills out the variable and array values, and this script then calls
#+installer.sh, passing the variable and array values to it.
#
source blfs_profile
if ! ((AS_SOURCE)); then
    /home/tommy/Copy/LFS/BLFS/package_installer/installer.sh \
        $(readlink -nf $BASH_SOURCE)
else
#
DATE=$(date +%Y%m%d)
TIME=$(date +%H%M%S)
# If executed with command line options, then instead of running installer
#+the arguments should be used to modify the variables. Handy for simple
#+version update - DON'T forget MD5SUM though!!!
if [ ${#} -gt 1 ]; then
    sed -i "s:^${1}=.*$:${1}=${2}:" $(readlink -nf $BASH_SOURCE)
    exit 0
fi
#
# For programs that don't do parallel build well (or at all!)
#PARALLEL=1
##############################################################################
#*************** Ordered list of variables from genscript.sh ****************#
##############################################################################
# Variables
PROG=basket
VERSION=1.81
ARCHIVE=tar.bz2
MD5=
DL_URL=http://$PROG.kde.org/downloads/?file=$PROG-$VERSION
DL_ALT=
PATCH=
BOOTSCRIPT=
PROGGROUP=
PROGUSER=
USRCMNT=
PREFICKS=/usr
SYSCONFDER=/etc
LOCALST8DER=/var
CONFIG_OPTS=..
CONFIGURE=cmake
MAKE_OPTS=
TEST=
TEST_OPTS=
INSTALL_OPTS=
# Number of additional/optional processes, typically downloads such as
#+patches or documentation.
DL_ADD_NUM=0
#
# Arrays - Each is a list that must be separated from the
#+others by a blank line
required=()
# conf[plus/minus]required aren't often used
confplus_required=()
confminus_required=()
#
recommended=()
confplus_recommended=()
confminus_recommended=()
optional=()
confplus_optional=()
confminus_optional=()
optdoc=()
confplus_optdoc=()
confminus_optdoc=()
runreqrd=()
# conf[plus/minus]runreqrd aren't often used
confplus_runreqrd=()
confminus_runreqrd=()
#
runrec=()
confplus_runrec=()
confminus_runrec=()
runopt=()
confplus_runopt=()
confminus_runopt=()
kernel=()
confplus_kernel=()
confminus_kernel=()
PRE_CFG_CMDS=(mkdir@@build cd@@build)
POST_CFG_CMDS=()
PRE_CHK_CMDS=()
POST_CHK_CMDS=()
PRE_INS_CMDS=()
POST_INS_CMDS=()
# Associative Arrays - get echoed here

# Export the variables
export  PROG VERSION TEST TEST_OPTS ARCHIVE MD5 DL_URL DL_ALT PATCH BOOTSCRIPT PROGGROUP PROGUSER USRCMNT PREFICKS SYSCONFDER LOCALST8DER CONFIG_OPTS CONFIGURE MAKE_OPTS TEST TEST_OPTS INSTALL_OPTS DL_ADD_NUM
# Export the arrays
export  required recommended optional optdoc runreqrd runrec runopt kernel confplus_required confplus_recommended confplus_optional confplus_optdoc confplus_runreqrd confplus_runrec confplus_runopt confplus_kernel confminus_kernel DL_ADD confminus_required confminus_recommended confminus_optional confminus_optdoc confminus_runreqrd confminus_runrec confminus_runopt PRE_CFG_CMDS POST_CFG_CMDS PRE_CHK_CMDS POST_CHK_CMDS PRE_INS_CMDS POST_INS_CMDS
# Export the associative arrays
export 
#######################################################################
#***** End of variable and array values supplied by genscript.sh *****#
#######################################################################
fi

