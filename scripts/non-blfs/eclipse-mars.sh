#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
# I've also included PyDev
#
# Dependencies
#**************
# Begin Required
#unzip-6.0
# End Required
# Begin Required Runtime
#java-1.8.0.51
# End Required Runtime
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
REINSTALL=0
grep "eclipse_cpp" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
[ -d $HOME/bin ] || mkdir -v $HOME/bin
pushd $HOME/bin
# Download:
wget http://ftp.ussg.iu.edu/eclipse/technology/epp/downloads/release/mars/R/eclipse-cpp-mars-R-linux-gtk-x86_64.tar.gz
# FTP/alt Download:
#wget http://mirrors.xmission.com/eclipse/technology/epp/downloads/release/mars/R/eclipse-cpp-mars-R-linux-gtk-x86_64.tar.gz
#
# md5sum:
echo "dc8a40fa49392b3de3fa94470e61afdb eclipse-cpp-mars-R-linux-gtk-x86_64.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# PyDev download
wget http://sourceforge.net/projects/pydev/files/pydev/PyDev%204.2.0/PyDev%204.2.0.zip
# md5sum:
echo "d992614d6d4477621e4d8fa629c26370 eclipse-cpp-mars-R-linux-gtk-x86_64.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xf eclipse-cpp-mars-R-linux-gtk-x86_64.tar.gz
pushd eclipse/dropins
unzip ../../"PyDev 4.2.0.zip"
popd
as_root install -Dm755 -g root -o root -t eclipse /opt/eclipse_cpp-mars
as_root ln -sfv eclipse_cpp-mars /opt/eclipse
ln -sv /opt/eclipse/eclipse $HOME/bin/eclipse
#
# Add to installed list for this computer:
echo "eclipse_cpp-mars" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

