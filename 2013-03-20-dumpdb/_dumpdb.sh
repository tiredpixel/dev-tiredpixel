#!/bin/bash

database=$1

dump="${database}_`date -u '+%Y-%m-%dT%H:%M:%S%z'`.sql.gz"
link="${database}_latest.sql.gz"

mysqldump "$database" | gzip > "$dump"

ln -sf "$dump" "$link"
ls -l "$link"
