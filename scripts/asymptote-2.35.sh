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
#ghostscript-9.16
#texlive-20150521
# End Required
# Begin Recommended
#freeglut-3.0.0
#gc-7.4.2
# End Recommended
# Begin Optional
#fftw
#gsl-1.16
#imaging-1.1.7
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep asymptote-2.35 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/sourceforge/asymptote/asymptote-2.35.src.tgz
# md5sum:
echo "199e971792072527bd0cb1583d8ef3fb asymptote-2.35.tgz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf asymptote-2.35.tgz
cd asymptote-2.35
export TEXARCH=$(uname -m | sed -e 's/i.86/i386/' -e 's/$/-linux/')
./configure --prefix=/opt/texlive/2015 \
 --bindir=/opt/texlive/2015/bin/$TEXARCH \
 --datarootdir=/opt/texlive/2015/texmf-dist \
 --infodir=/opt/texlive/2015texmf-dist/doc/info \
 --libdir=/opt/texlive/2015/texmf-dist \
 --mandir=/opt/texlive/2015/texmf-dist/doc/man \
 --enable-gc=system \
 --with-latex=/opt/texlive/2015/texmf-dist/tex/latex \
 --with-context=/opt/texlive/2015/texmf-dist/tex/context/third
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf asymptote-2.35
#
# Add to installed list for this computer:
echo "asymptote-2.35" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################