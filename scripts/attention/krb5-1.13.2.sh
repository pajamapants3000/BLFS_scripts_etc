#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for krb5-1.13.2
#
# Dependencies
#**************
# Begin Required
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#dejagnu-1.5.3
#gnupg-2.1.7
#keyutils-1.5.9
#openldap-2.4.42
#python-2.7.10
#rpcbind-0.2.3
# End Optional
# Begin Kernel
# End Kernel
#
# Optional dependency check
OPENLDAP=0
if (grep openldap /list-$CHRISTENED"-"$SURNAME); then OPENLDAP=1; fi
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep krb5-1.13.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://web.mit.edu/kerberos/www/dist/krb5/1.13/krb5-1.13.2-signed.tar
# md5sum:
echo "f7ebfa6c99c10b16979ebf9a98343189 krb5-1.13.2-signed.tar" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf krb5-1.13.2-signed.tar
tar -xvf krb5-1.13.2.tar.gz
cd krb5-1.13.2
# w/ GnuPG: Verify, then import the public key and reverify
#gpg2 --verify krb5-1.13.2.tar.gz.asc krb5-1.13.2.tar.gz
#gpg2 --keyserver pgp.mit.edu --recv-keys 0055C305
#gpg2 --verify krb5-1.13.2.tar.gz.asc krb5-1.13.2.tar.gz
#
cd src
sed -e "s@python2.5/Python.h@& python2.7/Python.h@g" \
    -e "s@-lpython2.5]@&,\n  AC_CHECK_LIB(python2.7,main,[PYTHON_LIB=-lpython2.7])@g" \
    -i configure.in
sed -e 's@\^u}@^u cols 300}@' \
    -i tests/dejagnu/config/default.exp
autoconf
if (($OPENLDAP)); then
    ./configure --prefix=/usr            \
                --sysconfdir=/etc        \
                --localstatedir=/var/lib \
                --with-system-et         \
                --with-system-ss         \
                --with-system-verto=no   \
                --with-ldap              \
                --enable-dns-for-realm
else
    ./configure --prefix=/usr            \
                --sysconfdir=/etc        \
                --localstatedir=/var/lib \
                --with-system-et         \
                --with-system-ss         \
                --with-system-verto=no   \
                --enable-dns-for-realm
fi
make
# w/ Tcl, plus Optional deps: Test
#make check
#
as_root make install
if (($OPENLDAP)); then
    for LIBRARY in gssapi_krb5 gssrpc k5crypto kadm5clnt kadm5srv \
                   kdb5 kdb_ldap krad krb5 krb5support verto ; do
        as_root chmod -v 755 /usr/lib/lib$LIBRARY.so
    done
else
    for LIBRARY in gssapi_krb5 gssrpc k5crypto kadm5clnt kadm5srv \
                   kdb5 kdb_ldap krad krb5 krb5support verto ; do
        as_root chmod -v 755 /usr/lib/lib$LIBRARY.so
    done
fi
unset LIBRARY
as_root mv -v /usr/lib/libkrb5.so.3*        /lib
as_root mv -v /usr/lib/libk5crypto.so.3*    /lib
as_root mv -v /usr/lib/libkrb5support.so.0* /lib
as_root ln -v -sf ../../lib/libkrb5.so.3.3        /usr/lib/libkrb5.so
as_root ln -v -sf ../../lib/libk5crypto.so.3.1    /usr/lib/libk5crypto.so
as_root ln -v -sf ../../lib/libkrb5support.so.0.1 /usr/lib/libkrb5support.so
as_root mv -v /usr/bin/ksu /bin
as_root chmod -v 755 /bin/ksu
as_root install -v -dm755 /usr/share/doc/krb5-1.13.2
as_root cp -vfr ../doc/*  /usr/share/doc/krb5-1.13.2
unset LIBRARY
#
cd ../..
as_root rm -rf krb5-1.13.2
#
# Add to installed list for this computer:
echo "krb5-1.13.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Init Script
#*************
cd blfs-bootscripts-20150823
as_root make install-krb5
cd ..
#
###################################################
#
# Configuration
#***************
source ${HOME}/.blfs_profile
as_root tee /etc/krb5.conf << "EOF"
# Begin /etc/krb5.conf

[libdefaults]
    default_realm = $DOMAINCAPS
    encrypt = true

[realms]
    $DOMAINCAPS = {
        kdc = $DOMAIN.$HOSTNAME
        admin_server = $DOMAIN.$HOSTNAME
        dict_file = /usr/share/dict/words
    }

[domain_realm]
    .$HOSTNAME = $DOMAINCAPS

[logging]
    kdc = SYSLOG[:INFO[:AUTH]]
    admin_server = SYSLOG[INFO[:AUTH]]
    default = SYSLOG[[:SYS]]

# End /etc/krb5.conf
EOF
as_root sed -i s/\$DOMAINCAPS/$DOMAINCAPS/ /etc/krb5.conf
as_root sed -i s/\$DOMAIN/$DOMAIN/ /etc/krb5.conf
as_root sed -i s/\$HOSTNAME/$HOSTNAME/ /etc/krb5.conf
#
# The rest should be done manually:
#kdb5_util create -r $DOMAINCAPS -s
#kadmin.local
#kadmin.local: add_policy dict-only
#kadmin.local: addprinc -policy dict-only $LOGINNAME
#kadmin.local: addprinc -randkey host/$DOMAIN.$HOSTNAME
#kadmin.local: ktadd host/$DOMAIN.$HOSTNAME
#quit
# Start the KDC daemon manually, just to test out the installation:
#/usr/sbin/krb5kdc
#kinit <loginname>
## Enter password
#klist
## Information about the ticket should be displayed on the screen.
##
## To test the functionality of the keytab file, issue the following command:
#ktutil
#ktutil: rkt /etc/krb5.keytab
#ktutil: l
# This should dump a list of the host principal, along with the encryption
#   methods used to access the principal.
# At this point, if everything has been successful so far, you can feel fairly
#   confident in the installation and configuration of the package.
#
# Additional Information
#   For additional information consult the documentation for krb5-1.13.2 on
#   which the above instructions are based.
#
###########################################################################
#
#
# If you forgot to set the necessary environment variables, you can
# manually edit /etc/krb5.conf
#
###############################
