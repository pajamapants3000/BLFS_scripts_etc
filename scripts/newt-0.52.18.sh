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
#popt-1.16
#s_lang-2.2.4
# End Required
# Begin Recommended
#gpm-1.20.7
# End Recommended
# Begin Optional
#python-2.7.10
#python-3.4.3
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep newt-0.52.18 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://fedorahosted.org/releases/n/e/newt/newt-0.52.18.tar.gz
#
# md5sum:
echo "685721bee1a318570704b19dcf31d268 newt-0.52.18.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf newt-0.52.18.tar.gz
cd newt-0.52.18
sed -e 's/^LIBNEWT =/#&/' \
    -e '/install -m 644 $(LIBNEWT)/ s/^/#/' \
    -e 's/$(LIBNEWT)/$(LIBNEWTSONAME)/g' \
        -i Makefile.in
./configure --prefix=/usr --with-gpm-support
make
#
as_root make install
cd ..
as_root rm -rf newt-0.52.18
#
# Add to installed list for this computer:
echo "newt-0.52.18" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
