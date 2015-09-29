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
#gnutls-3.4.4.1
#cups_filters-1.0.74
# End Required
# Begin Recommended
#colord-1.2.12
#d_bus-1.8.18
#libusb-1.0.19
# End Recommended
# Begin Optional
#avahi-0.6.31
#libpaper-1.1.24+nmu4
#linux_pam-1.2.1
#krb5-1.13.2
#openjdk-1.8.0.45
#php-5.6.12
#python-2.7.10
#xdg_utils-1.1.0-rc3 
#gutenprint-5.2.10
#hplip
# End Optional
# Begin Kernel
#CONFIG_USB_SUPPORT
#CONFIG_USB_OHCI_HCD
#CONFIG_USB_UHCI_HCD
#CONFIG_USB_PRINTER
#CONFIG_PARPORT
#CONFIG_PARPORT_PC
#CONFIG_PRINTER
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep cups-2.0.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://www.cups.org/software/2.0.3/cups-2.0.3-source.tar.bz2
# md5sum:
echo "8d98b85edbdab7ab03739c9622f570e8 cups-2.0.3.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf cups-2.0.3.tar.bz2
cd cups-2.0.3
if ! cat /etc/group | grep lpadmin > /dev/null; then
    pathappend /usr/sbin
    as_root useradd -c "Print_Service_User" -d /var/spool/cups -g lp -s /bin/false -u 9 lp
    as_root groupadd -g 19 lpadmin
    # Add tommy
    as_root usermod -a -G lpadmin tommy
    pathremove /usr/sbin
fi
# Replace firefox below if desired, with brpwser of choice
if ! cat /list-$CHRISTENED"-"$SURNAME | grep xdg_utils > /dev/null; then
sed -i 's#@CUPS_HTMLVIEW@#firefox#' desktop/cups.desktop.in
fi
sed -i 's:555:755:g;s:444:644:g' Makedefs.in
sed -i '/MAN.EXT/s:.gz::g' configure config-scripts/cups-manpages.m4
sed -i '/LIBGCRYPTCONFIG/d' config-scripts/cups-ssl.m4
sed -i 's@else /\* HAVE_AVAHI \*/@elif defined(HAVE_AVAHI)@' test/ippserver.c
aclocal  -I config-scripts
autoconf -I config-scripts
./configure --libdir=/usr/lib            \
            --disable-systemd            \
            --with-rcdir=/tmp/cupsinit   \
            --with-system-groups=lpadmin \
            --with-docdir=/usr/share/cups/doc-2.0.3
make
# Test (need graphical session):
make check
#
as_root make install
as_root rm -rf /tmp/cupsinit
as_root ln -svnf ../cups/doc-2.0.3 /usr/share/doc/cups-2.0.3
su 'echo "ServerName /var/run/cups/cups.sock" > /etc/cups/client.conf'
as_root rm -rf /usr/share/cups/banners
as_root rm -rf /usr/share/cups/data/testprint
if ! cat /list-$CHRISTENED"-"$SURNAME | grep "gtk+-" > /dev/null; then
as_root gtk-update-icon-cache
fi
cd ..
as_root rm -rf cups-2.0.3
#
# Add to installed list for this computer:
echo "cups-2.0.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-cups
cd ..
#
###################################################
#
# Configuration
#***************
#
cat > /etc/pam.d/cups << "EOF"
# Begin /etc/pam.d/cups

auth    include system-auth
account include system-account
session include system-session

# End /etc/pam.d/cups
EOF
###################################################
