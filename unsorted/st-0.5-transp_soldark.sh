#!/bin/bash -ev
# Installation script for st
# Version: transparency support, solarized dark colorscheme
# Requirements: Xlib header files
# Download:
wget http://dl.suckless.org/st/st-0.5.tar.gz
#
tar -xf st-0.5.tar.gz
cd st-0.5
PATCHDIR=$(dirname ${BASH_SOURCE[0]})
patch -p1 < ../"${PATCHDIR}"/../patches/st-0.5-transp_soldark.diff
sudo make clean install
cd ..
sudo rm -rf st-0.5
rm st-0.5.tar.gz
