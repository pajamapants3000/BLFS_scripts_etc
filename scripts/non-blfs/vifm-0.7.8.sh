#!/bin/bash -ev
# Installation script for VIFM-0.7.8
# VI-based file manager
# Requirements: ncurses built as a shared library; ASCII-compliant terminal
# Optional: Perl, VIM
# Check for previous installation:
PROCEED="yes"
grep vifm-0.7.8 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/vifm/files/vifm/vifm-0.7.8.tar.bz2
#
tar -xvf vifm-0.7.8.tar.bz2
cd vifm-0.7.8
./configure --prefix=/usr
make
as_root make install
cd ..
as_root rm -rf vifm-0.7.8
#
sed -i 's@"\(set runtimepath+=/usr/share/vifm/vim-doc/\)@\1@' ~/.vimrc
sed -i 's@"\(set runtimepath+=/usr/share/vifm/vim/\)@\1@' ~/.vimrc
#
# Installed flawlessly!
# Add to list of installed programs on this system
echo "vifm-0.7.8" >> /list-$CHRISTENED"-"$SURNAME
#
