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
#glib-2.44.1
# End Required
# Begin Recommended
#aspell-0.60.6.1
# End Recommended
# Begin Optional
#dbus_glib-0.104
#hspell
#hunspell
#voikko
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep enchant-1.6.0 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.abisource.com/downloads/enchant/1.6.0/enchant-1.6.0.tar.gz
# FTP/alt Download:
#wget ftp://ftp.netbsd.org/pub/pkgsrc/distfiles/enchant-1.6.0.tar.gz
#
# md5sum:
echo "de11011aff801dc61042828041fb59c7 enchant-1.6.0.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf enchant-1.6.0.tar.gz
cd enchant-1.6.0
./configure --prefix=/usr --disable-static
make
#
as_root make install
#
# link in aspell
as_root ln -svfn ../../lib/aspell /usr/share/enchant/aspell
#
# test it!
cat > /tmp/test-enchant.txt << "EOF" 
Tel me more abot linux
Ther ar so many commads
EOF
enchant -d en_US -l /tmp/test-enchant.txt
enchant -d en_US -a /tmp/test-enchant.txt
rm /tmp/test-enchant.txt
# You will see a list of the misspelled words followed by a list
#+of alternatives for them
#
cd ..
as_root rm -rf enchant-1.6.0
#
# Add to installed list for this computer:
echo "enchant-1.6.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################