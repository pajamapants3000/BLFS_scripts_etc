#!/bin/bash -ev
# Installation script for calibre_latest_git_binary
# Updated 07/20/2015
#
# Installs using python, easy!
# Can also install from source, but I don't really see the point,
#   and the calibre developers strongly advise against it.
# All dependencies are included!
# Just requires: xdg-utils, wget, sudo, and python >= 2.6 (python2 only?)
# Runtime deps: GLIBC <= 2.13, libstdc++.so.6.0.17 (from gcc 4.7.0) or higher
# Optional commands:
#   wget --no-check-certificate if root certs not installed. Apply this switch
#   if unstrusted certificate error is obtained.
#   Pass alternate prefix (e.g. /opt or /usr/local) as arg to main
#       e.g. main('/opt')
#   I'm not sure what the default is, so I will pass it /usr/local just to be safe
# main() also takes a second Boolean argument, defaulting to False, that tells
#   it to install an "isolated" version, that does not touch any files outside
#   the installation directory, and can be run without root permissions. 
#   I'm not gonna set this now, but I do like this idea.
#
# Dependencies
#**************
# Begin Required
#xdg_utils-1.1.0-rc3
#wget-1.16.3
#sudo-1.8.14p3
#python-2.7.10
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
grep calibre_latest_git_binary /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
sudo -v && wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('/usr/local')"
# To uninstall, run
# $sudo calibre-uninstaller
# Simply run again to upgrade. Latest version is 2.12.0
# Add to list of installed programs on this system
echo "calibre_latest_git_binary" >> /list-$CHRISTENED"-"$SURNAME
#