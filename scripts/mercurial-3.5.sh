#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for mercurial-3.5
#
# Dependencies
#**************
# Begin Required
#python-2.7.10
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#cvs-1.11.23
#git-2.5.0
#gnupg-2.1.7
#subversion-1.8.13
#bazaar
#docutils
#pyflakes
#pygments
#pyopenssl
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep "mercurial-" /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://mercurial.selenic.com/release/mercurial-3.5.tar.gz
# md5sum:
echo "3e3010e12759d3783ab7ed93de627da1 mercurial-3.5.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf mercurial-3.5.tar.gz
cd mercurial-3.5
make build
# with docutils
#make doc
#
# Test (kind of a lot of work and take FOREVER and still fails!):
#cat > tests/blacklists/failed-tests << "EOF"
## Test Failures
#   test-gpg.t
#EOF
#rm -rf tests/tmp
#TESTFLAGS="-j5 --tmpdir tmp --blacklist blacklists/failed-tests" \
#make check
#
# Examine failed tests, e.g. here test-parse-date.t:
#pushd tests
#rm -rf tmp
#./run-tests.py --debug --tmpdir tmp test-parse-date.t
#popd
#
as_root make PREFIX=/usr install-bin
#
# with docutils, install docs
#as_root make PREFIX=/usr install-doc
#
cd ..
as_root rm -rf mercurial-3.5
#
# Add to installed list for this computer:
echo "mercurial-3.5" >> /list-$CHRISTENED"-"$SURNAME
#
(($REINSTALL)) && exit 0 || (exit 0)
#
cat >> ~/.hgrc << "EOF"
[ui]
username = Tommy Lincoln <pajamapants3000@gmail.com>
EOF
#
as_root install -v -d -m755 /etc/mercurial
as_root tee /etc/mercurial/hgrc << "EOF"
[web]
cacerts = /etc/ssl/ca-bundle.crt
EOF
#
###################################################
#
# Test by running
#
#$hg debuginstall
#
# View output ("no problems detected")
#
#$hg
###################################################
