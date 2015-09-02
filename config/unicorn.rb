worker_processes 3
timeout 30
preload_app true

pid 'tmp/pids/unicorn.pid'
stderr_path 'log/unicorn.stderr.log'
stdout_path 'log/unicorn.stdout.log'

before_fork do |server, worker|
  # The master process doesn't need a database connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
  
  # Kill off old master servers
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  # Reestablish DB connection in workers
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
