rails_root  = ENV['RAILS_ROOT'] || "/home/USER/APP"
num_workers = 2

# Read .env file, as used by Foreman. Thus, there is but one config, and God will respect this.
env_vars    = {}
File.read(File.join(rails_root, ".env")).split("\n").reject(&:empty?).each { |l| v = l.split("="); env_vars[v[0]] = (v[1] || "") }

num_workers.times do |num|
  God.watch do |w|
    w.dir      = "#{rails_root}"
    w.name     = "resque-#{num}"
    w.group    = 'resque'
    w.interval = 30.seconds
    w.env      = env_vars
    w.log      = File.expand_path(File.join(w.dir, "log", "resque.log"))
    w.start    = "bundle exec rake resque:work"

    w.uid = 'USER'
    w.gid = 'GROUP'

    # restart if memory gets too high
    w.transition(:up, :restart) do |on|
      on.condition(:memory_usage) do |c|
        #c.above = 350.megabytes
        c.above = 128.megabytes
        c.times = 2
      end
      
      on.condition(:restart_file_touched) do |c|
        c.interval = 5.seconds
        c.restart_file = File.join(rails_root, 'tmp', 'restart.txt')
      end
    end

    # determine the state on startup
    w.transition(:init, { true => :up, false => :start }) do |on|
      on.condition(:process_running) do |c|
        c.running = true
      end
    end

    # determine when process has finished starting
    w.transition([:start, :restart], :up) do |on|
      on.condition(:process_running) do |c|
        c.running = true
        c.interval = 5.seconds
      end

      # failsafe
      on.condition(:tries) do |c|
        c.times = 5
        c.transition = :start
        c.interval = 5.seconds
      end
    end

    # start if process is not running
    w.transition(:up, :start) do |on|
      on.condition(:process_running) do |c|
        c.running = false
      end
    end
  end
end