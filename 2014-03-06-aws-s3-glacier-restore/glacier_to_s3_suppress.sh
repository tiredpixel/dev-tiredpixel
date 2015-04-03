#!/bin/sh

# SEE: http://stackoverflow.com/questions/20033651/how-to-restore-folders-or-entire-buckets-to-amazon-s3-from-glacier
# SEE: https://github.com/aws/aws-cli

echo $1

# ignore errors
aws s3api restore-object --restore-request Days=14 --bucket BUCKET --key $1 || true