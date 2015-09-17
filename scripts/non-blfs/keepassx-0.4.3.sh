#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for keepassx-0.4.3
#
source blfs_profile
#
# Dependencies
#**************
# Begin Required
#qt-4.8.7
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
grep "keepassx-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
#wget http://www.keepassx.org/releases/keepassx-0.4.3.tar.gz
# md5sum:
echo "1df67bb22b2e08df49f09e61d156f508 keepassx-0.4.3.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf keepassx-0.4.3.tar.gz
cd keepassx-0.4.3
if (cat /list-${CHRISTENED}-${SURNAME} | grep "qt-4" > /dev/null); then
    if (cat /list-${CHRISTENED}-${SURNAME} | grep "qt-5" > /dev/null); then
        if (echo $PATH | grep qt5); then
            QTVERSET=5
            source setqt4
        elif ! (echo $PATH | grep qt4); then
            source setqt4
        fi
    elif ! (echo $PATH | grep qt4); then
        source setqt4
    fi
else
    echo "keepassx-0.4.3 will not build without qt4"
    echo "Please install qt4 and try installing keepassx-0.4.3 again"
    exit E_MISSINGDEP
fi
patch -p1 < ../patches/keepassx-0.4.3.patch
qmake PREFIX=/usr
make -j${PARALLEL}
#
exit 0
#as_root make -j${PARALLEL} install
cd ..
as_root rm -rf keepassx-0.4.3
#
if [ $QTVERSET == 5 ]; then
    source setqt5
fi
#
# Add to installed list for this computer:
echo "keepassx-0.4.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################

