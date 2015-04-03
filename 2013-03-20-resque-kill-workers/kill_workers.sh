# Thanks be to http://www.kensodev.com/2011/09/17/kill-all-resque-workers-with-a-single-command/ .

echo `ps aux | grep [r]esque | grep -v grep | cut -c 10-16`

sudo kill -9  `ps aux | grep [r]esque | grep -v grep | cut -c 10-16`
