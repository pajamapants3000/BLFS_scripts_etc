#!/bin/bash -ev
wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.tar.gz
tar -xvf 1.017R.tar.gz
sudo mkdir -v /usr/share/fonts/TTF/source-code-pro
sudo cp -v source-code-pro-1.017R/TTF/* /usr/share/fonts/TTF/source-code-pro/
rm -rf source-code-pro-1.017R
rm 1.017R.tar.gz
fc-cache
