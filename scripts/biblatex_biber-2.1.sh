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
#autovivification-0.16
#Business::ISBN-2.09
#Business::ISMN-1.13
#Business::ISSN-0.91
#Data::Compare-1.25
#Data::Dump-1.23
#Date::Simple-3.03
#Encode::EUCJPASCII-0.03
#Encode::HanExtra-0.23
#Encode::JIS2K-0.03
#File::Slurp-9999.19
#IPC::Run3-0.048
#Log::Log4perl-1.46
#libwww-perl-6.13
#List::AllUtils-0.09
#Module-Build-0.4214
#Regexp::Common-2013031301
#Text::BibTeX-0.71
#Text::Roman-3.5
#Unicode::Collate-1.14
#Unicode::LineBreak-2015.06
#XML::LibXML::Simple-0.95
#XML::LibXSLT-1.94
#XML::Writer-0.625
#texlive-20150521
# End Required
# Begin Recommended
#File::Which-1.18
#Test::Differences-0.63
#Test::Pod-1.51
#Test::Pod::Coverage-1.10
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
grep biblatex-biber-2.1 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/biblatex-biber/files/biblatex-biber/2.1/biblatex-biber.tar.gz
# md5sum:
echo "XXX biblatex-biber-2.1.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required patch
wget http://www.linuxfromscratch.org/patches/blfs/svn/biblatex-biber-2.1-upstream_fixes-1.patch
# Corresponding version of biblatex
wget http://sourceforge.net/projects/biblatex/files/biblatex-3.0/biblatex-3.0.tds.tgz
# md5sum:
echo "c6dad1c1f8a46785981610b5165d9fe5 biblatex-3.0.tds.tgz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf biblatex-biber-2.1.tar.gz
cd biblatex-biber-2.1
patch -Np1 -i ../biblate-biber-2.1-upstream_fixes-1.patch
sed -i 's/ 44/ 43/' t/bcfvalidation.t
perl ./Build.PL
./Build
#
as_root make install
cd ..
as_root tar -xf ../biblatex-3.0.tds.tgz -C /opt/texlive/2015/texmf-dist
as_root texhash
as_root ./Build install
#
# Add to installed list for this computer:
echo "biblatex-biber-2.1" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################