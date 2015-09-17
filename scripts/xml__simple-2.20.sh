#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for xml__simple-current
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
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "xml__simple-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
cpan -i Tie::IxHash           \
        XML::LibXML           \
        XML::SAX::Expat       \
        XML::SAX::Base        \
        XML::NamespaceSupport \
        XML::SAX              \
        XML::Simple
#
# Add to installed list for this computer:
echo "xml__simple-current" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
