#!/bin/bash -ev
# Installation script for pyqt-5.5
#
# Dependencies
#**************
# Begin Required
#qt-5.5.0
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
source blfs_profile
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep pyqt-5.5 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/pyqt/files/PyQt5/PyQt-5.5/PyQt-gpl-5.5.tar.gz
# md5sum:
echo "60c0137b26c9ecbc3db0addb9638dc01 PyQt-gpl-5.5.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf PyQt-gpl-5.5.tar.gz
cd PyQt-gpl-5.5
setqt5
[ $QT_INSTALL_PLUGINS ] || export QT_INSTALL_PLUGINS="${QT5DIR}/plugins"
python3 ./configure.py  --confirm-license       \
                        --bindir=/opt/pyqt5/bin \
                        --destdir=/opt/pyqt5
make -j$PARALLEL
#
as_root make -j$PARALLEL install
cd ..
as_root rm -rf PyQt-gpl-5.5
#
# Set environment
as_root install -o root -g root -Dm644 files/pyqt5.sh /etc/profile.d/pyqt5.sh
as_root ln -sfv /etc/profile.d/pyqt5.sh /etc/profile.d/active/65-pyqt.sh
as_root tee -a /etc/profile.d/bash_envar.sh << "EOF"
"PYQT5_SIP_DIR=/usr/share/sip/PyQt5"

EOF
#
# Add to installed list for this computer:
echo "pyqt-5.5" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
