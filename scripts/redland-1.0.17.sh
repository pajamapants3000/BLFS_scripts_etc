#!/bin/bash -ev
# Beyond Linux From Scratch
# Installation script for redland-1.0.17
#
# Dependencies
#**************
# Begin Required
#rasqal-0.9.33
# End Required
# Begin Recommended
# End Recommended
# Begin Optional
#db-6.1.26
#libiodbc-3.52.10
#sqlite-3.8.11.1
#mariadb-10.0.20
#mysql
#postgresql-9.4.4
#virtuoso,
#3store
# End Optional
# Begin Kernel
# End Kernel
#
# Installation
#**************
# Check for previous installation:
PROCEED="yes"
REINSTALL=0
grep redland-1.0.17 /list-$CHRISTENED"-"$SURNAME > /dev/null && ((\!$?)) &&\
    REINSTALL=1 && echo "Previous installation detected, proceed?" && read PROCEED
[ $PROCEED = "yes" ] || [ $PROCEED = "y" ] || exit 0
# Download:
wget http://download.librdf.org/source/redland-1.0.17.tar.gz
# md5sum:
echo "e5be03eda13ef68aabab6e42aa67715e redland-1.0.17.tar.gz" | md5sum -c ;\
    ( exit ${PIPESTATUS[0]} )
#
tar -xvf redland-1.0.17.tar.gz
cd redland-1.0.17
./configure --prefix=/usr --disable-static
make
# Test:
make check
#
as_root make install
cd ..
as_root rm -rf redland-1.0.17
#
# Add to installed list for this computer:
echo "redland-1.0.17" >> /list-$CHRISTENED"-"$SURNAME
#
###################################################