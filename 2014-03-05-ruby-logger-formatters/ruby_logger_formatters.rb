require 'logger'

logger = Logger.new($stdout)
logger.progname = "P"


# = default Logger::Formatter

logger.info "!!!"
#=> I, [2014-03-05T15:26:04.897151 #19997]  INFO -- P: !!!


# = almost Logger::Formatter, but with Z UTC timezone identifier

logger.formatter = proc { |severity, datetime, progname, msg|
  "#{severity[0]}, [#{datetime.utc.iso8601(6)} ##{Process.pid}]  #{severity} -- #{progname}: #{msg}#{$/}"
}

logger.info "!!!"
#=> I, [2014-03-05T15:26:25.270971Z #19997]  INFO -- P: !!!


# = almost Logger::Formatter, but with Z UTC and PPID

logger.formatter = proc { |severity, datetime, progname, msg|
  "#{severity[0]}, [#{datetime.utc.iso8601(6)} ##{Process.ppid} > ##{Process.pid}]  #{severity} -- #{progname}: #{msg}#{$/}"
}

logger.info "!!!"
#=> I, [2014-03-05T15:29:18.927927Z #90949 > #19997]  INFO -- P: !!!
