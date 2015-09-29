#!/bin/bash -ev
# Written by: Tommy Lincoln <pajamapants3000@gmail.com>
# Github: https://github.com/pajamapants3000
# Legal: See LICENSE in parent directory
#
#
# Dependencies
#**************
# Begin Required
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
grep oxygen_fonts-5.2.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.kde.org/stable/plasma/5.2.0/oxygen-fonts-5.2.0.tar.xz
# md5sum:
echo "4868641ea354177bca6873e7798398ad oxygen-fonts-5.2.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf oxygen-fonts-5.2.0.tar.xz
cd oxygen-fonts-5.2.0/oxygen-fonts
as_root install -d /usr/share/fonts/X11/TTF/oxygen-fonts-5.2.0/
as_root cp -v Bold-700/Oxygen-Sans-Bold.ttf /usr/share/fonts/X11/TTF/oxygen-fonts-5.2.0/
as_root cp -v mono-400/OxygenMono-Regular.ttf /usr/share/fonts/X11/TTF/oxygen-fonts-5.2.0/
as_root cp -v Regular-400/Oxygen-Sans.ttf /usr/share/fonts/X11/TTF/oxygen-fonts-5.2.0/
cd ../..
as_root rm -rf oxygen-fonts-5.2.0
#
# Add to installed list for this computer:
echo "oxygen_fonts-5.2.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################