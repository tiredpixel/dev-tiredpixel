#!/bin/bash

# Backup MySQL database using mysqldump, storing in AWS S3.

# SEE: http://aws.amazon.com/cli/
# This must be configured (aws configure).

# Set the following environment variables:
# - BACKUP_DATABASE
# - BACKUP_S3

set -e


tmpdir=`mktemp -d -t backup_mysql_tmpdir.XXXXXX`

trap "{ rm -rf $tmpdir; }" EXIT

cd $tmpdir


dumplocz="mysql_${BACKUP_DATABASE}_`date -u '+%Y-%m-%dT%H:%M:%S%z'`.sql.bz2"

time mysqldump $BACKUP_DATABASE | bzip2 --best > "$dumplocz"

s3path="s3://$BACKUP_S3/$dumplocz"

time /usr/local/bin/aws s3 cp "$dumplocz" "$s3path"
