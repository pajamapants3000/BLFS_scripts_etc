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
# End Required
# Begin Recommended
#python-2.7.10
#ruby-2.2.3
#ghostscript-9.16
#X Window System
#fontconfig-2.11.1
#freetype-2.6
#gc-7.4.2
#graphite2-1.3.0
#harfbuzz-1.0.2
#icu-55.1
#libpaper-1.1.24+nmu4
#libpng-1.6.18
#poppler-0.35.0
# End Recommended
# Begin Optional
#gd
#t1lib
#zziplib
#teckit
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep texlive-20150521 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://tug.org/texlive/historic/2015/texlive-20150521-source.tar.xz
# md5sum:
echo "e526bd57118c4c4d5e9d525d20b5ac02 texlive-20150521.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Required additional download:
wget ftp://tug.org/texlive/historic/2015/texlive-20150523-texmf.tar.xz
# md5sum:
echo "488c1e36ab42841b122cfd074ac42fa1 texlive-20150523-texmf.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
# Prep work
export TEXARCH=$(uname -m | sed -e 's/i.86/i386/' -e 's/$/-linux/')
as_root tee -a /etc/profile.d/extrapaths.sh << EOF

# Begin texlive addition

pathappend /opt/texlive/2015/texmf-dist/doc/man  MANPATH
pathappend /opt/texlive/2015/texmf-dist/doc/info INFOPATH
pathappend /opt/texlive/2015/bin/$TEXARCH

# End texlive addition

EOF
unset TEXARCH
source /etc/profile
as_root tee -a /etc/ld.so.conf << EOF
# Begin texlive 2015 addition

/opt/texlive/2015/lib

# End texlive 2015 addition
EOF
tar -xvf texlive-20150521.tar.xz
cd texlive-20150521
export TEXARCH=$(uname -m | sed -e 's/i.86/i386/' -e 's/$/-linux/')
mkdir texlive-build
cd texlive-build
# Make sure the --with-system options are for installed libraries
../configure                                        \
    --prefix=/opt/texlive/2015                      \
    --bindir=/opt/texlive/2015/bin/$TEXARCH         \
    --datarootdir=/opt/texlive/2015                 \
    --includedir=/opt/texlive/2015/include          \
    --infodir=/opt/texlive/2015/texmf-dist/doc/info \
    --libdir=/opt/texlive/2015/lib                  \
    --mandir=/opt/texlive/2015/texmf-dist/doc/man   \
    --disable-native-texlive-build                  \
    --disable-static --enable-shared                \
    --with-system-cairo                             \
    --with-system-fontconfig                        \
    --with-system-freetype2                         \
    --with-system-gmp                               \
    --with-system-graphite2                         \
    --with-system-harfbuzz                          \
    --with-system-icu                               \
    --with-system-libgs                             \
    --with-system-libpaper                          \
    --with-system-libpng                            \
    --with-system-mpfr                              \
    --with-system-pixman                            \
    --with-system-poppler                           \
    --with-system-xpdf                              \
    --with-system-zlib                              \
    --with-banner-add=" - BLFS"
make
# Test:
make check
#
as_root make install-strip
as_root make texlinks
as_root ldconfig
as_root mkdir -pv /opt/texlive/${TEXYEAR}/tlpkg/TeXLive/
as_root install -v -m444 ../texk/tests/TeXLive/* /opt/texlive/${TEXYEAR}/tlpkg/TeXLive/
as_root tar -xf ../../texlive-20150523-texmf.tar.xz -C /opt/texlive/2015 --strip-components=1
as_root mktexlsr
as_root fmtutil-sys --all
as_root mtxrun --generate
cd ..
as_root rm -rf texlive-20150521
#
# Add to installed list for this computer:
echo "texlive-20150521" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################