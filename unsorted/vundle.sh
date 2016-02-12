#!/bin/bash
[ -d ${HOME}/.vim/bundle ] || mkdir -pv ${HOME}/.vim/bundle
cd ${HOME}/.vim
git clone http://github.com/gmarik/Vundle.vim bundle/vundle
