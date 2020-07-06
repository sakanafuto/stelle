app_path = '/var/www/stelle'

worker_processes 2
working_directory "#{app_path}" + "/current"

# This loads the application in the master process before forking
# worker processes
# Read more about it here:
# http://unicorn.bogomips.org/Unicorn/Configurator.html
preload_app true

timeout 30

# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
#listen "#{app_path}/tmp/sockets/unicorn.sock", :backlog => 64
listen "/tmp/unicorn.sock", :backlog => 64

#pid "/tmp/unicorn.pid"
pid "#{app_path}/shared/tmp/pids/unicorn.pid"

# Set the path of the log files inside the log folder of the testapp
stderr_path "#{app_path}/current/log/unicorn.stderr.log"
stdout_path "#{app_path}/current/log/unicorn.stdout.log"

before_fork do |server, worker|
  ENV['BUNDLE_GEMFILE'] = File.expand_path('Gemfile', ENV['RAILS_ROOT'])
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end