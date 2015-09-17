#!/bin/bash -ev
# Install script for vim-qt
git clone https://github.com/equalsraf/vim-qt.git
cd vim-qt
source loadqt4
patch -p1 < ../patches/vim-qt.patch
make config
make
sudo make install
