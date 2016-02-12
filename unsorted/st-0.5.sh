#!/bin/bash -ev
# Installation script for st
# Version: plain
# Requirements: Xlib header files
# Download:
wget http://dl.suckless.org/st/st-0.5.tar.gz
#
tar -xf st-0.5.tar.gz
cd st-0.5
patch -p1 < ../"$(dirname ${BASH_SOURCE[0]})"/../patches/st-0.5.diff
sudo make clean install
cd ..
sudo rm -rf st-0.5
rm st-0.5.tar.gz
