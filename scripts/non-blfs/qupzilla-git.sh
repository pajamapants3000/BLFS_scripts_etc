#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for qupzilla-git
#
# Dependencies
#**************
# Begin Required
#cmake-3.3.1
#openssl-1.0.2d
#qt-5.5.0
#qt-4.8.7
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#gdb-7.9.1
#kdelibs-4.14.10
#hunspell
#libgnome_keyring
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "qupzilla-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Clone repository:
git clone git://github.com/QupZilla/qupzilla.git
#
cd qupzilla
sed -e '/qtlocalpeer/ i #include <QDataStream>' \
        -i src/lib/3rdparty/qtsingleapplication/qtlocalpeer.cpp
sed -e '/QHash/ i #include <QObject>' \
    -i src/plugins/TabManager/tldextractor/tldextractor.h
#
sed -e 's/^TargetEnvironment/#&/'              \
    -e 's/Categories=/&Application;Internet;/' \
    -i  linux/applications/qupzilla.desktop
#
if (cat /list-${CHRISTENED}-${SURNAME} | grep kdelibs > /dev/null); then
export QUPZILLA_PREFIX=/usr \
       USE_WEBGL=true       \
       KDE_INTEGRATION=true
else
export QUPZILLA_PREFIX=/usr \
       USE_WEBGL=true
fi
qmake
make
#
as_root make install
#
if (cat /list-${CHRISTENED}-${SURNAME} | grep xdg_utils > /dev/null); then
    as_root xdg-icon-resource forceupdate --theme hicolor
fi
if (cat /list-${CHRISTENED}-${SURNAME} | grep desktop_file_utils > /dev/null); then
    as_root update-desktop-database -q
fi
#
cd ..
as_root rm -rf qupzilla
#
# Add to installed list for this computer:
echo "qupzilla-git" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#


