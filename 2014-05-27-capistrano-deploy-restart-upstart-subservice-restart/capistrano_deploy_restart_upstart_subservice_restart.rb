desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence do
      execute :touch, release_path.join('tmp/restart.txt')
      
      wait_s = 10
      
      application_re = Regexp.escape(fetch(:application))
      
      execute(%Q{sudo bash -c 'for sname in $(initctl list | grep "^#{application_re}\\-[a-zA-Z_]\\+\\-[0-9]\\+\\b" | cut -d'\\'' '\\'' -f1); do echo "RESTARTING $(hostname -f) SERVICE $sname" && service $sname restart && sleep #{wait_s}; done'})
      execute(%Q{sudo sh -c 'service #{fetch(:application)} start || true'})
    end
  end
end