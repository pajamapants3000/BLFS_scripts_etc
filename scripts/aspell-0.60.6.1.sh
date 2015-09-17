#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for aspell-0.60.6.1
#
# Dependencies
#**************
# Begin Required
#which-2.21
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
grep aspell-0.60.6.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://ftp.gnu.org/gnu/aspell/aspell-0.60.6.1.tar.gz
# FTP/alt Download:
#wget ftp://ftp.gnu.org/gnu/aspell/aspell-0.60.6.1.tar.gz
#
# md5sum:
echo "e66a9c9af6a60dc46134fdacf6ce97d7 aspell-0.60.6.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required download - English Dictionary
wget https://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-2015.04.24-0.tar.bz2
#
tar -xvf aspell-0.60.6.1.tar.gz
cd aspell-0.60.6.1
./configure --prefix=/usr
make
#
as_root make install
as_root ln -svfn aspell-0.60 /usr/lib/aspell
as_root install -v -m755 -d /usr/share/doc/aspell-0.60.6.1/aspell{,-dev}.html
as_root install -v -m644 manual/aspell.html/* \
    /usr/share/doc/aspell-0.60.6.1/aspell.html
as_root install -v -m644 manual/aspell-dev.html/* \
    /usr/share/doc/aspell-0.60.6.1/aspell-dev.html
#
# If you do not plan to install ispell/spell, copy the respective wrapper scripts
as_root install -v -m 755 scripts/ispell /usr/bin/
as_root install -v -m 755 scripts/spell /usr/bin/
#
cd ..
as_root rm -rf aspell-0.60.6.1
# Install dictionary
tar -xf aspell6-en-2015.04.24-0.tar.bz2
cd aspell6-en-2015.04.24-0
./configure
make
as_root make install
cd ..
as_root rm -rf aspell6-en-2015.04.24-0
#
# Add to installed list for this computer:
echo "aspell-0.60.6.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################