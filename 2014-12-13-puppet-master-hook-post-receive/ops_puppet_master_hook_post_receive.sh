#!/bin/sh

set -e

GIT_WORK_TREE=/etc/puppet git checkout -f

cd /etc/puppet && librarian-puppet install

sudo puppet agent --test
