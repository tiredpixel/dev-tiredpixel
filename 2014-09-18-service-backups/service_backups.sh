#!/bin/sh

# A list of one-line service backups, suitable for use as Cron schedules. Files
# overwrite rather than including a timestamp, to allow for easy updates from a
# dedicated backup program such as Duplicity.
# 
# All backups are written to /root/backups , and compressed using bzip2 .

PATH=/usr/sbin:/usr/bin:/sbin:/bin


## MySQL
BACKUP_DATABASE=eg_database DEST="/root/backups/mysql_$BACKUP_DATABASE.sql.bz2" && mysqldump "$BACKUP_DATABASE" | bzip2 --best > "$DEST.tmp" && mv "$DEST.tmp" "$DEST"

## PostgreSQL
BACKUP_DATABASE=eg_database DEST="/var/lib/postgresql/backups/postgresql_$BACKUP_DATABASE.sql.bz2" && pg_dump --no-acl --no-owner "$BACKUP_DATABASE" | bzip2 --best > "$DEST.tmp" && mv "$DEST.tmp" "$DEST"

## Redis
# relies on redis.conf settings to periodically BGSAVE, rather than triggering save itself
DEST="/root/backups/redis_dump.rdb.bz2" && cat "$(redis-cli CONFIG GET dir | grep "/")/dump.rdb" | bzip2 --best > "$DEST.tmp" && mv "$DEST.tmp" "$DEST"
