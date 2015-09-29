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
#clisp-2.49
#texlive-20150521
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
grep xindy-2.5.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://tug.ctan.org/support/xindy/base/xindy-2.5.1.tar.gz
# md5sum:
echo "221acfeeb0f6f8388f89a59c56491041 xindy-2.5.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf xindy-2.5.1.tar.gz
cd xindy-2.5.1
export TEXARCH=$(uname -m | sed -e 's/i.86/i386/' -e 's/$/-linux/')
./configure --prefix=/opt/texlive/2015              \
            --bindir=/opt/texlive/2015/bin/$TEXARCH \
            --datarootdir=/opt/texlive/2015         \
            --includedir=/usr/include               \
            --libdir=/opt/texlive/2015/texmf-dist   \
            --mandir=/opt/texlive/2015/texmf-dist/doc/man
make LC_ALL=POSIX
#
as_root make install
cd ..
as_root rm -rf xindy-2.5.1
#
# Add to installed list for this computer:
echo "xindy-2.5.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################