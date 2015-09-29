#!/bin/bash -e
# Beyond Linux From Scratch 7.6
# Install series generator
#
# To do: Allow for argument for different install list.
#   Complication: Need flags for more than one optional argument.
#
LISTDIR="/home/tommy/Copy/LFS/BLFS"
SCRIPTDIR="${LISTDIR}/scripts"
LIST="ENL"
LISTFILE="list-"$LIST
PREFIX=${1:-$LIST}
#
if [ ! -e $LISTDIR/$LISTFILE]; then
    echo "I'm not seeing that list..."
    exit 1
fi
i=1
for file in $(sed 's@^#.*$@@' $LISTDIR/$LISTFILE); do
    if [ -e $SCRIPTDIR/$file".sh" ]; then
        echo $SCRIPTDIR/$file".sh"
    elif [ -e $SCRIPTDIR"/non-blfs/"$file".sh" ]; then
        echo $SCRIPTDIR"/non-blfs/"$file".sh"
    elif [ -e $SCRIPTDIR"/attention/"$file".sh" ]; then
        echo $SCRIPTDIR"/attention/"$file".sh"
    elif [ -e $SCRIPTDIR"/../Xorg/"$file".sh" ]; then
        echo $SCRIPTDIR"/../Xorg/"$file".sh"
    else
        echo "Error: can't find $file"
        echo "Check list against filenames"
        exit 1
    fi
done
for file in $(sed 's@^#.*$@@' $LISTDIR/$LISTFILE); do
[ ! x"${1}" = x"-a" ] && grep ${file%%-*} /list-$CHRISTENED"-"$SURNAME > /dev/null ||
    if [ -e $SCRIPTDIR/$file".sh" ]; then
        ln -svf $file".sh" $SCRIPTDIR/$PREFIX"-$(printf "%02d" $i)-"$file".sh" &&
        ((i+=1))
    elif [ -e $SCRIPTDIR"/non-blfs/"$file".sh" ]; then
        ln -svf "non-blfs/"$file".sh" $SCRIPTDIR/$PREFIX"-$(printf "%02d" $i)-"$file".sh" &&
        ((i+=1))
    elif [ -e $SCRIPTDIR"/attention/"$file".sh" ]; then
        ln -svf "breaker.sh" $SCRIPTDIR/$PREFIX"-$(printf "%02d" $i)-"breaker".sh" &&
        ((i+=1))
        ln -svf "attention/"$file".sh" $SCRIPTDIR/$PREFIX"-$(printf "%02d" $i)-"$file".sh" &&
        ((i+=1))
    elif [ -e $SCRIPTDIR"/../Xorg/"$file".sh" ]; then
        ln -svf "../Xorg/"$file".sh" $SCRIPTDIR/$PREFIX"-$(printf "%02d" $i)-"$file".sh" &&
        ((i+=1))
    else exit 1
    fi
done
