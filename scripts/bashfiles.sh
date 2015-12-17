#!/bin/bash -ev
#
# Installation Script
# Bash shell startup files and other initial configurations
######################
#
### RUN AS ROOT!!! ###
#
######################
#
# Check for previous installation:
PROCEED="yes"
grep bashfiles /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
#
source /etc/bashrc
#
dircolors -p > /etc/dircolors
#
for FILE in $(ls file/etc); do
    if [ -f file/etc/$FILE ]; then
        cp -v file/etc/"${FILE}" /etc/
        chown -v root:root /etc/"${FILE}"
        chmod -v 755 /etc/"${FILE}"
    fi
done

#
useradd -m -U -G wheel,video,audio,usb,cdrom -s /bin/bash tommy
#
mkdir -pv /home/tommy/.config/bash
cp -rv files/home/profile/.config/bash/* /home/tommy/.config/bash/
chown -vR tommy:tommy /home/tommy/.config/bash/
chmod -vR 644 /home/tommy/.config/bash
chmod -v 755 /home/tommy/.config/bash
#
tar -xvf sources/blfs-bootscripts-${BLFS_BOOTSCRIPTS_VER}.tar.bz2
cd blfs-bootscripts-${BLFS_BOOTSCRIPTS_VER}
make install-random
cd ..
#
cp -v sources/* ./
# Add to list of installed programs on this system
echo "bashfiles" >> /list-${CHRISTENED}-${SURNAME}
#
chown -v tommy:tommy /list-${CHRISTENED}-${SURNAME}
chown -R tommy:tommy ${PWD}
#
echo "Now passwd tommy and exit and log in as tommy"
echo "Then continue installing; begin START!"
######################################################
