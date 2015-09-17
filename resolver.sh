#!/bin/bash -ev
#
# Resolver
#
# Resolves dependencies
#
# MUCH more complicated than I thought it would be! WIP!
#
declare -a DEPSTREE=$2
declare -a INSTALL_LIST=$3
declare -a MISSING_DEPS=$4
declare -a MISSING_LISTS=$5

declare -a CIRCDEPS
set CIRCNUM=0
CIRCDEPS[${#CIRCDEPS[@]}]="${CIRCNUM}"
function copyarray ()
{
    local a=$1
    local len_a=${#a[@]}
    local b=$2
    local len_b=${#b[@]}
    local copystart=${3:-0}
    local copystop=${4:-${len_b}}
    for ((i=0;i < len_b;i++))
    {
        a[((len_a + i))]=${b[$i]}
    }
}
function contains ()
{
    local n=$#
    local value=${!n}
    for ((i=1;i < $#;i++))
    {
        if [ "${!i}" == "${value}"* ]; then
            echo "y"
            return $i
        fi
    }
    echo "n"
    return 0
}

function process_deps ()
{
    declare -a DEPSLIST
    LEVEL=${#DEPSDEPTH[@]}
    while read LINE
    do
        if [ "${LINE:0:1}" == '#' ]; then
            continue
        fi
        PROGNAM=${LINE%%-*}
        VERMOD=${LINE#*-}
        declare -a PROGVER
        PROGVER=$( echo ${VERMOD%%-*} | tr "." " ")
        PROGMOD=${VERMOD##*-}



    done < ${DEPS_LIST}

    [ $LEVEL == 1 ] || unset DEPSTREE[$((LEVEL - 1))]
}

function circular_check ()
{
    declare -a arrlist
    arrlist=${1[@]}
    test_string=$2
    if [ $(contains "${arrlist[@]}" "${test_string}") == "y" ]; then
        copyarray CIRCDEPS arrlist $?
        CIRCDEPS[${#CIRCDEPS[@]}]="${test_string}"
        CIRCNUM=((CIRCNUM + 1))
        CIRCDEPS[${#CIRCDEPS[@]}]="${CIRCNUM}"
        continue
    fi
}

function installed ()
{
    local name=$1
    declare -a ver
    ver=${2[@]}
    inst_prog=$(grep ${name} /list-$CHRISTENED"-"$SURNAME)
    [ -z ${inst_prog} ] && return 1
    declare -a inst_ver
    inst_ver=$( $(echo ${inst_prog} | tr "-" " ")[1] | tr "." " ")
    compar=$(vercomp ver inst_ver)
    [ ${compar} -ge 0 ] && return 0
    return 1
}

function accounted ()
{

}

function script_check ()
{

}

function deplist_check ()
{

}
