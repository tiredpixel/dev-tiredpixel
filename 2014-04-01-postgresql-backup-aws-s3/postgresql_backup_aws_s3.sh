#!/bin/bash

# Backup PostgreSQL database using pg_dump, storing in AWS S3.

# SEE: http://aws.amazon.com/cli/
# This must be configured (aws configure).

# Set the following environment variables:
# - PGUSER, etc.
# - BACKUP_DATABASE
# - BACKUP_S3

set -e


tmpdir=`mktemp -d -t backup_postgresql_tmpdir.XXXXXX`

trap "{ rm -rf $tmpdir; }" EXIT

cd $tmpdir


dumplocz="postgresql_${BACKUP_DATABASE}_`date -u '+%Y-%m-%dT%H:%M:%S%z'`.sql.bz2"

time pg_dump --no-acl --no-owner $BACKUP_DATABASE | bzip2 --best > "$dumplocz"

s3path="s3://$BACKUP_S3/$dumplocz"

time aws s3 cp "$dumplocz" "$s3path"
