#!/bin/bash

# Backup Redis database using redis-cli, storing in AWS S3.

# SEE: http://aws.amazon.com/cli/
# This must be configured (aws configure).

# Set the following environment variables:
# - BACKUP_S3

set -e


tmpdir=`mktemp -d -t backup_redis_tmpdir.XXXXXX`

trap "{ rm -rf $tmpdir; }" EXIT

cd $tmpdir


dumplocz="redis_`date -u '+%Y-%m-%dT%H:%M:%S%z'.dump.rdb.bz2`"

redis_lastsave_t0=$(redis-cli LASTSAVE)

redis-cli BGSAVE

while [ "$(redis-cli LASTSAVE)" == "$redis_lastsave_t0" ]
do
    sleep 1
done

redis_dir=$(redis-cli CONFIG GET dir | grep "/")
redis_dump="$redis_dir/dump.rdb"

cat "$redis_dump" | bzip2 > "$dumplocz"

s3path="s3://$BACKUP_S3/$dumplocz"

time /usr/local/bin/aws s3 cp "$dumplocz" "$s3path"
