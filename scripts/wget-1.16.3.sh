#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for wget-1.16.3
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
#gnutls-3.4.4.1
# End Recommended
# Begin Optional
#libidn-1.31
#openssl-1.0.2d
#pcre-8.37
#libwww-perl-6.13
#IO::Socket::SSL
#valgrind-3.10.1
#libpsl
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep wget-1.16.3 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download - Can't wget! Unless upgrading. Here for reference anyway:
(($REINSTALL)) && \
        wget http://ftp.gnu.org/gnu/wget/wget-1.16.3.tar.xz
# FTP/alt Download:
#wget ftp://ftp.gnu.org/gnu/wget/wget-1.16.3.tar.xz
#
# md5sum:
echo "d2e4455781a70140ae83b54ca594ce21 wget-1.16.3.tar.xz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf wget-1.16.3.tar.xz
cd wget-1.16.3
grep gnutls /list-$CHRISTENED"-"$SURNAME > /dev/null && \
./configure --prefix=/usr      \
            --sysconfdir=/etc ||
./configure --prefix=/usr      \
            --sysconfdir=/etc  \
            --with-ssl=openssl
make
# Test (HTTPS tests fail if openssl is used and valgrind is enabled):
make -k check 2>&1 | tee ../logs/"$(basename $0)"-log; \
STAT=${PIPESTATUS[0]}; ( exit 0 )
if (( STAT )); then
    echo "Some tests failed; log in ../$(basename $0)-log"
    echo "Pull up another terminal and check the output"
    echo "Shall we proceed? (say "'"yes"'" or "'"y"'" to proceed)"
    read PROCEED
    [ "$PROCEED" = "y" ] || [ "$PROCEED" = "yes" ]
fi
#
as_root make install
grep certdata /list-$CHRISTENED"-"$SURNAME > /dev/null && \
    as_root echo ca-directory=/etc/ssl/certs >> /etc/wgetrc || (exit 0)
cd ..
as_root rm -rf wget-1.16.3
#
# Add to installed list for this computer:
echo "wget-1.16.3" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
