#!/bin/bash -v
# Beyond Linux From Scratch 7.6
# Install series runner
# Pass START number as argument
# Default: runs numbers 1 to 99
#####################################################################
export START=${1:-1}
export STOP=${2:-99}
time { for NUM in $(seq -f "%02g" $START $STOP); do
(($?)) && break || ./scripts/$LIST"-"$NUM"-"*".sh"; done; }
((NUM--))
echo "Left off at number "$NUM
NEXT=$((NUM + 1))
echo "Ensure this is completed, then continue at "$NEXT
