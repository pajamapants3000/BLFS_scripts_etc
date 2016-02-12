#!/bin/bash -ev
# Install script for vim-qt in KaOS
[ -d ${HOME}/repos ] || mkdir -pv ${HOME}/repos
cd ${HOME}/repos
hg clone https://vim.googlecode.com/hg/ vim
cd vim
patch -p1 < "$(dirname ${BASH_SOURCE[0]})"/../patches/vim-KaOS_patch.diff
make config
make
echo "Install step left out; if vim-qt already installed, simply take..."
echo "...vim executable which contains gtk2 gui and leave the rest."
