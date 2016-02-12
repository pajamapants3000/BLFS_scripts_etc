#!/bin/bash -ev
# Installation script for VIFM-0.7.8
# VI-based file manager
# Requirements: ncurses built as a shared library; ASCII-compliant terminal
# Optional: Perl, VIM
wget http://sourceforge.net/projects/vifm/files/vifm/vifm-0.7.8.tar.bz2
#
tar -xvf vifm-0.7.8.tar.bz2
cd vifm-0.7.8
./configure --prefix=/usr
make
sudo make install
cd ..
sudo rm -rf vifm-0.7.8
sed -i 's@"\(set runtimepath+=/usr/share/vifm/vim-doc/\)@\1@' ~/.vimrc
sed -i 's@"\(set runtimepath+=/usr/share/vifm/vim/\)@\1@' ~/.vimrc
