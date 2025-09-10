#!/bin/bash
set -e

PGDATA="${PGDATA:=/var/lib/postgresql/data}"

if [ ! -f $PGDATA/PG_VERSION ]; then
    initdb -D $PGDATA
fi

pg_ctl start -D $PGDATA

for i in {1..30}; do
    if pg_isready -U postgres; then
        break
    fi
done

psql -U postgres -c "CREATE EXTENSION IF NOT EXISTS pgtap;"