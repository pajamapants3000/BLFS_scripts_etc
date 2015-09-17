#!/bin/bash -ev
# Installation script for asciidoc-8.6.9
# Requirements: Only main requirement is python. (not specific)
# Additional requirements - README lists the following tools present for
#   known-working asciidocs:
#   Python 2.6.5; DocBook XSL Stylesheets 1.76.1;xsltproc (libxml 20706,
#   libxslt 10126 and libexslt 815); w3m 0.5.2; dblatex 0.3; FOP 0.95
#   and A-A-P 1.091
# Check for previous installation:
PROCEED="yes"
grep asciidoc-8.6.9 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://sourceforge.net/projects/asciidoc/files/asciidoc/8.6.9/asciidoc-8.6.9.tar.gz
tar -xzf asciidoc-8.6.9.tar.gz
cd asciidoc-8.6.9
./configure --prefix=/usr
as_root make install
# Optionally, install documentation:
as_root make docs
cd ..
as_root rm -rf asciidoc-8.6.9
# Flawless!
# Add to list of installed programs on this system
echo "asciidoc-8.6.9" >> /list-$CHRISTENED"-"$SURNAME
#