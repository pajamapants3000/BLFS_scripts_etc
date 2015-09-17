#!/bin/bash -e
# Beyond Linux From Scratch 7.6
# Set list used by generator.sh
# Can also set main ("list") folder or script root folder.
# Pass var to change as first arg, then value as second.
VARTOCHANGE=$1
PARAM=$2
if [ $VARTOCHANGE = "-h" -o $VARTOCHANGE = "--help" ] ; then
    echo "usage: ./setlist.sh [variable to set] [new value]"
    echo "[variable to set] can be one of:"
    echo "      list"
    echo "      listdir"
    echo "      scriptdir"
    echo "list should be a NAME so that there exists a matching"
    echo 'list-NAME in ${listdir}'
    echo
    echo "Wrtten by Tommy Lincoln <pajamapants3000@gmail.com"
    echo
    exit 0
fi
([ $VARTOCHANGE = "LIST" -o $VARTOCHANGE = "list" ] &&
sed -i s@"^\(LIST=\).*$"@"\1\"$PARAM\""@ generator.sh &&
echo "LIST changed to \"$PARAM\"") ||
([ $VARTOCHANGE = "LISTDIR" -o $VARTOCHANGE = "listdir" ] &&
sed -i s@"^\(LISTDIR=\).*$"@"\1\"$PARAM\""@ generator.sh &&
echo "LISTDIR changed to \"$PARAM\"" &&
if [ ! -d $PARAM ]; then echo "Warning: directory doesn't exist!"; fi) ||
([ $VARTOCHANGE = "SCRIPTDIR" -o $VARTOCHANGE = "scriptdir" ] &&
sed -i s@"^\(SCRIPTDIR=\).*$"@"\1\"$PARAM\""@ generator.sh &&
echo "SCRIPTDIR changed to \"$PARAM\"" &&
if [ ! -d $PARAM ]; then echo "Warning: directory doesn't exist!"; fi)