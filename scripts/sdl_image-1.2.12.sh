#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for SDL_image-1.2.12
#
# Dependencies
#**************
# Begin Required
#sdl-1.2.15
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
REINSTALL=0
grep "SDL_image-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.libsdl.org/projects/SDL_image/release/SDL_image-1.2.12.tar.gz
#
# md5sum:
#echo "XXX SDL2_image-1.2.12.tar.gz" | md5sum -c ;\
#    ( exit ${PIPESTATUS[0]} )
#
tar -xvf SDL_image-1.2.12.tar.gz
cd SDL_image-1.2.12
./configure --prefix=/usr
make
#
as_root make install
cd ..
as_root rm -rf SDL_image-1.2.12
#
# Add to installed list for this computer:
echo "SDL_image-1.2.12" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

