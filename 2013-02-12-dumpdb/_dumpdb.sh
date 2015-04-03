#!/bin/bash

# Script to create and download a database backup on Heroku
# Written by Chris Stefano (https://github.com/virtualstaticvoid)
# with customisations by tiredpixel (https://github.com/tiredpixel)
#
# See http://devcenter.heroku.com/articles/pgbackups for details

appname=$1
filename="${appname}_`date -u '+%Y-%m-%dT%H:%M:%S%z'`.dump"
latest="${appname}_latest.dump"

# list backup
# heroku pgbackups --app $appname

# may need to delete old backups:
# heroku pgbackups:destroy XXXX --app $appname

# create a backup
heroku pgbackups:capture --expire --app $appname

# get the temp URL for it (AWS S3)
backup_url=`heroku pgbackups:url --app $appname`

# download it locally
curl -o "$filename" "$backup_url"

# link to latest backup
ln -sf "$filename" "$latest"
ls -l "$latest"
