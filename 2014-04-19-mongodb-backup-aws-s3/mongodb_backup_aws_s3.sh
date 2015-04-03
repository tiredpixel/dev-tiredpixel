#!/bin/bash

# Backup MongoDB database using mongodump, storing in AWS S3.

# SEE: http://aws.amazon.com/cli/
# This must be configured (aws configure).

# Set the following environment variables:
# - BACKUP_DATABASE
# - BACKUP_S3

set -e


tmpdir=`mktemp -d -t backup_mongodb_tmpdir.XXXXXX`

trap "{ rm -rf $tmpdir; }" EXIT

cd $tmpdir


dumploc="mongodb_${BACKUP_DATABASE}_`date -u '+%Y-%m-%dT%H:%M:%S%z'`"
dumplocz="${dumploc}.tar.bz2"

time mongodump --db "$BACKUP_DATABASE" --out "$dumploc"

tar -cjf "$tmpdir/$dumplocz" "$dumploc"

s3path="s3://$BACKUP_S3/$dumplocz"

time /usr/local/bin/aws s3 cp "$dumplocz" "$s3path"