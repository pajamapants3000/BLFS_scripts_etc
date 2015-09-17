#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for alsa_tools-1.0.29
#
# Dependencies
#**************
# Begin Required
#alsa_lib-1.0.29
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gtk+-2.24.28
#gtk+-3.16.6
#flk-1.3.3
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep alsa_tools-1.0.29 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://alsa.cybermirror.org/tools/alsa-tools-1.0.29alsa-tools-1.0.29.tar.bz2
# FTP/alt Download:
#wget ftp://ftp.alsa-project.org/pub/tools/alsa-tools-1.0.29.tar.bz2
#
# md5sum:
echo "f339a3cd24f748c9d007bdff0e98775b alsa-tools-1.0.29.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf alsa-tools-1.0.29.tar.bz2
cd alsa-tools-1.0.29
rm -rf qlo10k1 Makefile gitcompile
for tool in *
do
  case $tool in
    seq )
      tool_dir=seq/sbiload
    ;;
    * )
      tool_dir=$tool
    ;;
  esac
  pushd $tool_dir
    ./configure --prefix=/usr
    make
    as_root make install
    as_root /sbin/ldconfig
  popd
done
unset tool tool_dir
#
cd ..
as_root rm -rf alsa-tools-1.0.29
#
# Add to installed list for this computer:
echo "alsa_tools-1.0.29" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################