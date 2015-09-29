#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
#glib-2.40.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#emacs-24.3
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
grep desktop_file_utils-0.22 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://freedesktop.org/software/desktop-file-utils/releases/desktop-file-utils-0.22.tar.xz
# md5sum:
echo "c6b9f9aac1ea143091178c23437e6cd0 desktop-file-utils-0.22.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
tar -xvf desktop-file-utils-0.22.tar.xz
cd desktop-file-utils-0.22
./configure --prefix=/usr
make
as_root make install
# self-explanatory, for .desktop files, see instructions. Not needed
#   for install, just put here for informational purposes.
#update-desktop-database /usr/share/applications
cd ..
as_root rm -rf desktop-file-utils-0.22
#
# Now enter graphical environment (twm) and in terminal (xterm) run:
# cd /sources/glib-2.40.0
# make -k check
# Will take about 3.4 SBU
# Add to list of installed programs on this system
echo "desktop_file_utils-0.22" >> /list-$CHRISTENED"-"$SURNAME
#