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
#qtermwidget-0.6.0
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#doxygen-1.8.10
#texlive-20150521
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "qterminal-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget https://github.com/qterminal/qterminal/releases/download/0.6.0/qterminal-0.6.0.tar.xz
# md5sum:
echo "a033e898d17fcd3b0f9a839b029b0db4 qterminal-0.6.0.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf qterminal-0.6.0.tar.xz
cd qterminal-0.6.0
mkdir build
cd    build
cmake -DCMAKE_BUILD_TYPE=Release  \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DUSE_SYSTEM_QXT=OFF        \
      -DUSE_QT5=true              \
      ..
make
#
if (cat /list-${CHRISTENED}-${SURNAME} | grep doxygen > /dev/null); then
    doxygen ../Doxyfile
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep texlive > /dev/null); then
    make -C docs/latex
fi
as_root make install
#
if (cat /list-${CHRISTENED}-${SURNAME} | grep texlive > /dev/null); then
    install -v -m755 -d /usr/share/doc/qterminal-0.6.0/{html,pdf} &&
    install -v -m644    docs/latex/refman.pdf \
                        /usr/share/doc/qterminal-0.6.0/pdf
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep doxygen > /dev/null); then
    cp -vr docs/html/* /usr/share/doc/qterminal-0.6.0/html
fi
#
cd ../..
as_root rm -rf qterminal-0.6.0
#
# Add to installed list for this computer:
echo "qterminal-0.6.0" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#

