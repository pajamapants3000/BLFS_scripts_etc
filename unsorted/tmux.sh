#!/bin/bash -ev
wget http://downloads.sourceforge.net/tmux/tmux-1.9a.tar.gz
tar -xf tmux-1.9a.tar.gz
cd tmux-1.9a
./configure --prefix=/usr
make
sudo make install
cd ..
rm -rf tmux-1.9a
rm tmux-1.9a.tar.gz
