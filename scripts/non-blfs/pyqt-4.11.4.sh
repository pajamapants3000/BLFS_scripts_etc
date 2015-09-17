#!/bin/bash -ev
# Installation script for pyqt-4.11.4
#
# Dependencies
#**************
# Begin Required
#qt-4.8.7
#python-3.4.3
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#python-2.7.10
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep pyqt-4.11.4 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.4/PyQt-x11-gpl-4.11.4.tar.gz
# md5sum:
echo "2fe8265b2ae2fc593241c2c84d09d481 PyQt-x11-gpl-4.11.4.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf PyQt-x11-gpl-4.11.4.tar.gz
cd PyQt-x11-gpl-4.11.4
setqt4
[ $QT_INSTALL_PLUGINS ] || export QT_INSTALL_PLUGINS="${QT4DIR}/plugin"
python3 ./configure-ng.py  INCPATH+="/usr/include/phonon" \
                           --confirm-license              \
                           --bindir=/opt/pyqt4/bin        \
                           --destdir=/opt/pyqt4
make
#
as_root make install
cd ..
as_root rm -rf PyQt-x11-gpl-4.11.4
#
as_root cp -v files/pyqt4.sh /etc/profile.d/
as_root chown root:root /etc/profile.d/pyqt4.sh
as_root chmod 644 /etc/profile.d/pyqt4.sh
#
# source for this session
PYQT4_SIP_DIR=/usr/share/sip/PyQt4
pathappend /opt/pyqt4/bin   PATH
pathappend /opt/pyqt4       PYTHONPATH
export PYQT4_SIP_DIR PATH PYTHONPATH
#
# Add to installed list for this computer:
echo "pyqt-4.11.4" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
