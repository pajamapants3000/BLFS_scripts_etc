#!/bin/bash -ev
#
# postgresql-9.4.5-config.sh
# Follow up configuration to be run as root from the postgresql
#+installation script
if [ ${UID} != 0 ]; then
    echo "This script must be run as root!"
    exit 1
fi
#su - postgres -c '/usr/bin/initdb -D /srv/pgsql/data'
su - postgres -c '/usr/bin/postgres -D /srv/pgsql/data > \
        /srv/pgsql/data/logfile 2>&1 &'
su - postgres -c '/usr/bin/createdb test'
echo "create table t1 ( name varchar(20), state_province varchar(20) );" \
        | (su - postgres -c '/usr/bin/psql test ')
echo "insert into t1 values ('Billy', 'NewYork');" \
        | (su - postgres -c '/usr/bin/psql test ')
echo "insert into t1 values ('Evanidus', 'Quebec');" \
        | (su - postgres -c '/usr/bin/psql test ')
echo "insert into t1 values ('Jesse', 'Ontario');" \
        | (su - postgres -c '/usr/bin/psql test ')
echo "select * from t1;" | (su - postgres -c '/usr/bin/psql test')
#
