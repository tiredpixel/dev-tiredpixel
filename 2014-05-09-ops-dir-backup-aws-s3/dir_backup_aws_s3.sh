#!/bin/bash

# Backup directory, storing in AWS S3.

# SEE: http://aws.amazon.com/cli/
# This must be configured (aws configure).

# Set the following environment variables:
# - BACKUP_DIR
# - BACKUP_TAG
# - BACKUP_S3

set -e


tmpdir=`mktemp -d -t backup_dir_tmpdir.XXXXXX`

trap "{ rm -rf $tmpdir; }" EXIT

cd $tmpdir


dumplocz="dir_${BACKUP_TAG}_`date -u '+%Y-%m-%dT%H:%M:%S%z'`.tar.bz2"

time tar -cjf "$tmpdir/$dumplocz" $BACKUP_DIR

s3path="s3://$BACKUP_S3/$dumplocz"

time aws s3 cp "$dumplocz" "$s3path"
