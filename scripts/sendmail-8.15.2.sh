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
#openldap-2.4.42-client
# End Required
# Begin Recommended
#openssl-1.0.2d
#cyrus_sasl-2.1.26 
# End Recommended
# Begin Optional
#procmail-3.22
#nph
#ghostscript-9.16
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep sendmail-8.15.2 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget ftp://ftp.sendmail.org/pub/sendmail/sendmail.8.15.2.tar.gz
# md5sum:
echo "a824fa7dea4d3341efb6462ccd816f00 sendmail.8.15.2.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf sendmail.8.15.2.tar.gz
cd sendmail.8.15.2
#
if ! (cat /etc/group | grep smmsp > /dev/null); then
    pathappend /usr/sbin
    as_root groupadd -g 26 smmsp
    as_root useradd -c "Sendmail_Daemon" -g smmsp -d /dev/null \
            -s /bin/false -u 26 smmsp
    pathremove /usr/sbin
fi
as_root chmod -v 1777 /var/mail
as_root install -v -m700 -d /var/spool/mqueue
#
as_root tee -a devtools/Site/site.config.m4 << "EOF"
APPENDDEF(`confENVDEF',`-DSTARTTLS -DSASL -DLDAPMAP')
APPENDDEF(`confLIBS', `-lssl -lcrypto -lsasl2 -lldap -llber -ldb')
APPENDDEF(`confINCDIRS', `-I/usr/include/sasl')
EOF
#
as_root tee -a devtools/Site/site.config.m4 << "EOF"
define(`confMANGRP',`root')
define(`confMANOWN',`root')
define(`confSBINGRP',`root')
define(`confUBINGRP',`root')
define(`confUBINOWN',`root')
EOF

sed -i 's|/usr/man/man|/usr/share/man/man|' \
    devtools/OS/Linux
#
cd sendmail
sh Build
cd ../cf/cf
cp generic-linux.mc sendmail.mc
sh Build sendmail.cf
#
as_root install -v -d -m755 /etc/mail
as_root sh Build install-cf
cd ../..
as_root sh Build install
as_root install -v -m644 cf/cf/{submit,sendmail}.mc /etc/mail
as_root cp -v -R cf/* /etc/mail
as_root install -v -m755 -d /usr/share/doc/sendmail-8.15.2/{cf,sendmail}
as_root install -v -m644 CACerts FAQ KNOWNBUGS LICENSE PGPKEYS README RELEASE_NOTES \
         /usr/share/doc/sendmail-8.15.2
as_root install -v -m644 sendmail/{README,SECURITY,TRACEFLAGS,TUNING} \
         /usr/share/doc/sendmail-8.15.2/sendmail
as_root install -v -m644 cf/README /usr/share/doc/sendmail-8.15.2/cf
for manpage in sendmail editmap mailstats makemap praliases smrsh
do
    as_root install -v -m644 $manpage/$manpage.8 /usr/share/man/man8
done
as_root install -v -m644 sendmail/aliases.5    /usr/share/man/man5
as_root install -v -m644 sendmail/mailq.1      /usr/share/man/man1
as_root install -v -m644 sendmail/newaliases.1 /usr/share/man/man1
as_root install -v -m644 vacation/vacation.1   /usr/share/man/man1
#
cd doc/op
sed -i 's/groff/GROFF_NO_SGR=1 groff/' Makefile
make op.txt
#
as_root install -v -d -m755 /usr/share/doc/sendmail-8.15.2
as_root install -v -m644 op.ps op.txt /usr/share/doc/sendmail-8.15.2
cd ../..
#
as_root echo $(hostname) > /etc/mail/local-host-names
as_root tee /etc/mail/aliases << "EOF"
postmaster: root
MAILER-DAEMON: root

EOF
as_root newaliases
#
cd /etc/mail
as_root m4 m4/cf.m4 sendmail.mc > sendmail.cf
#
# Add to installed list for this computer:
echo "sendmail-8.15.2" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################
#
# Init Script
#*************
#cd blfs-bootscripts-20150823
#as_root make install-sendmail
#cd ..
#
###################################################
