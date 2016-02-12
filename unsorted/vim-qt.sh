#!/bin/bash -ev
# Install script for vim-qt in KaOS
git clone https://bitbucket.org/equalsraf/vim-qt.git
cd vim-qt
patch -p1 < ../"$(dirname ${BASH_SOURCE[0]})"/../patches/vim-qt-KaOS_patch.diff
make config
make
sudo make install
