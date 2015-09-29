#!/bin/bash -ev
#
# Installation Script
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
#libglade-2.6.4
#shared_mime_info-1.4
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
#CONFIG_DNOTIFY
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep rox_filer-2.11 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/rox/rox-filer-2.11.tar.bz2
# md5sum:
echo "0eebf05a67f7932367750ebf9faf215d rox-filer-2.11.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf rox-filer-2.11.tar.bz2
cd rox-filer-2.11
cd ROX-Filer
sed -i 's:g_strdup(getenv("APP_DIR")):"/usr/share/rox":' src/main.c
mkdir build
pushd build
  ../src/configure LIBS="-lm -ldl"v
make
popd
#
as_root mkdir -p /usr/share/rox
as_root cp -av Help Messages Options.xml ROX images style.css .DirIcon /usr/share/rox
as_root cp -av ../rox.1 /usr/share/man/man1
as_root cp -v  ROX-Filer /usr/bin/rox
as_root chown -Rv root:root /usr/bin/rox /usr/share/rox
cd /usr/share/rox/ROX/MIME
as_root ln -sv text-x-{diff,patch}.png
as_root ln -sv application-x-font-{afm,type1}.png
as_root ln -sv application-xml{,-dtd}.png
as_root ln -sv application-xml{,-external-parsed-entity}.png
as_root ln -sv application-{,rdf+}xml.png
as_root ln -sv application-x{ml,-xbel}.png
as_root ln -sv application-{x-shell,java}script.png
as_root ln -sv application-x-{bzip,xz}-compressed-tar.png
as_root ln -sv application-x-{bzip,lzma}-compressed-tar.png
as_root ln -sv application-x-{bzip-compressed-tar,lzo}.png
as_root ln -sv application-x-{bzip,xz}.png
as_root ln -sv application-x-{gzip,lzma}.png
as_root ln -sv application-{msword,rtf}.png
cd ..
as_root rm -rf rox-filer-2.11
#
# Add to installed list for this computer:
echo "rox_filer-2.11" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
#
as_root ln -s ../rox/.DirIcon /usr/share/pixmaps/rox.png
as_root mkdir -p /usr/share/applications
as_root tee /usr/share/applications/rox.desktop << "HERE_DOC"
[Desktop Entry]
Encoding=UTF-8
Type=Application
Name=Rox
Comment=The Rox File Manager
Icon=rox
Exec=rox
Categories=GTK;Utility;Application;System;Core;
StartupNotify=true
Terminal=false
HERE_DOC
#
# (note "HERE_DOC just replaces "EOF")
###################################################
