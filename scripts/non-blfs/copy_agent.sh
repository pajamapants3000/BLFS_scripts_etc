#!/bin/bash -ev
# Installation script for copy_agent
# Updated as of 07/19/2015
#
#  copy.com sync installer
#  Dependencies: QT for CopyAgent. The rest should run on pretty much any
#+ Linux system. These are simply binaries with libs included.
#  UPDATE: CopyAgent seems to work even without QT. It is this that should
#  be used as a system-tray daemon.
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#qt-5.5.0
#qt-4.8.7
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
grep copy_agent /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
pushd ~
rm copy_agent*.tgz || (exit 0)
# Download:
wget https://copy.com/install/linux/Copy.tgz
tar -xvf Copy.tgz
rm Copy.tgz
mv -v copy copy_agent
[ ! -d ~/bin ] && mkdir -v ~/bin || (exit 0)
[ ! -e ~/bin/CopyAgent ]   && ln -sv ~/copy_agent/x86_64/CopyAgent   ~/bin/CopyAgent
[ ! -e ~/bin/CopyCmd ]     && ln -sv ~/copy_agent/x86_64/CopyCmd     ~/bin/CopyCmd
[ ! -e ~/bin/CopyConsole ] && ln -sv ~/copy_agent/x86_64/CopyConsole ~/bin/CopyConsole
popd
# Add to installed list for this computer:
echo "copy_agent" >> /list-$CHRISTENED"-"$SURNAME
#
#####################################################################
#  Installed:
#  CopyAgent – This is a QT based UI application for the Linux GUI
#  CopyConsole – This is a headless version of the Copy app. It can run
#+ in a terminal or as a background process
#  CopyCmd – This is a tool that provides commandline APIs into various
#+ aspects of the Copy app. You can do cool things like create a link
#+ URL to a file in your account or upload a file directly into
#+ the cloud
#  For more info, see ~/copy/README
#
#  For initial setup, simply run:
#CopyConsole -username=<email> -root=/home/<user>/Copy
#CopyConsole -username=pajamapants3000@gmail.com -root=/home/tommy/Copy
#####################################################################
