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
# End Recommended
# Begin Optional
# End Optional
# Begin Kernel
#CONFIG_USB_SUPPORT
#CONFIG_USB_OHCI_HCD
#CONFIG_USB_UHCI_HCD
#CONFIG_USB_PRINTER
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "gutenprint-5.2.10" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://downloads.sourceforge.net/gimp-print/gutenprint-5.2.10.tar.bz2
# md5sum:
echo "9ff027103bafac419c37e19da75163ae gutenprint-5.2.10.tar.bz2" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf gutenprint-5.2.10.tar.bz2
cd gutenprint-5.2.10
sed -i 's|$(PACKAGE)/doc|doc/$(PACKAGE)-$(VERSION)|' \
       {,doc/,doc/developer/}Makefile.in
./configure --prefix=/usr --disable-static
make
# Test (CRAZY long - like 800SBU):
#make check
#
as_root make install
as_root install -v -m755 -d /usr/share/doc/gutenprint-5.2.10/api/gutenprint{,ui2}
as_root install -v -m644    doc/gutenprint/html/* \
                    /usr/share/doc/gutenprint-5.2.10/api/gutenprint
as_root install -v -m644    doc/gutenprintui2/html/* \
                    /usr/share/doc/gutenprint-5.2.10/api/gutenprintui2
cd ..
as_root rm -rf gutenprint-5.2.10
#
# Add to installed list for this computer:
echo "gutenprint-5.2.10" >> /list-$CHRISTENED"-"$SURNAME
#
# refresh cups to see new drivers
as_root /etc/rc.d/init.d/cups restart
###################################################
#
# point your web browser to http://localhost:631/ to add a new printer to CUPS
#
###################################################
