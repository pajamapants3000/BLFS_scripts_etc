#!/bin/bash
# Source Code Pro Installer
#####################################################################
wget https://github.com/adobe-fonts/source-code-pro/archive/1.017R.tar.gz
tar -xvf 1.017R.tar.gz
as_root mkdir -v /usr/share/fonts/X11/TTF/source-code-pro
as_root cp -v source-code-pro-1.017R/TTF/* /usr/share/fonts/X11/TTF/source-code-pro/
rm -rf source-code-pro-1.017R
rm 1.017R.tar.gz
as_root fc-cache
#####################################################################
# To see possible font references to use,
#$fc-list | grep SourceCodePro | less
# E.g. Source\ Code\ Pro:style=Regular:size=18
#####################################################################
