#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# Version: transparency support, solarized dark colorscheme
# Requirements: Xlib header files
# Download:
source ${HOME}/.blfs_profile
#
#wget http://dl.suckless.org/st/st-0.5.tar.gz
#
tar -xf st-0.5.tar.gz
cd st-0.5
patch -p1 < ${PATCHDIR}/st-0.5-superT.patch
sudo make clean install
cd ..
sudo rm -rf st-0.5
#rm st-0.5.tar.gz
