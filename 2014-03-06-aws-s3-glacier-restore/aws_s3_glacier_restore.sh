# list recursively all objects in bucket, running in parallel with concurrency 10
aws s3 ls --recursive s3://BUCKET | awk '{print $4}' | xargs -L 1 -P 10 ./glacier_to_s3_suppress.sh