#!/bin/bash -ev
# Install script for vim-qt
source blfs_profile
git clone https://github.com/equalsraf/vim-qt.git
cd vim-qt
#source loadqt4
patch -p1 < ${PATCHDIR}/vim-qt.patch
make config
make -j${PARALLEL}
sudo make install
