#!/bin/bash -ev
# Beyond Linux From Scratch
# Main run - 02
# Installation script for lsb_release-1.4
# Time: less than 0.1 SBU 
# Check for previous installation:
PROCEED="yes"
grep lsb-release-1.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
# http://sourceforge.net/projects/lsb/files/lsb_release/1.4/lsb-release-1.4.tar.gz
# md5sum:
# 30537ef5a01e0ca94b7b8eb6a36bb1e4
tar -xvf lsb-release-1.4.tar.gz
cd lsb-release-1.4
sed -i "s|n/a|unavailable|" lsb_release
./help2man -N --include ./lsb_release.examples \
              --alt_version_key=program_version ./lsb_release > lsb_release.1
as_root install -v -m 644 lsb_release.1 /usr/share/man/man1/lsb_release.1
as_root install -v -m 755 lsb_release /usr/bin/lsb_release
cd ..
as_root rm -rf lsb-release-1.4

# Add to list of installed programs on this system
echo "lsb-release-1.4" >> /list-$CHRISTENED-$SURNAME
#
