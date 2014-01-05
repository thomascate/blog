worker_processes 2
working_directory "/home/deploy/current"

# This loads the application in the master process before forking
# worker processes
# Read more about it here:
# http://unicorn.bogomips.org/Unicorn/Configurator.html
preload_app true

timeout 30

# This is where we specify the socket.
# We will point the upstream Nginx module to this socket later on
listen "/home/deploy/shared/unicorn.sock", :backlog => 64

pid "/home/deploy/shared/unicorn.pid"

# Set the path of the log files inside the log folder of the testapp
stderr_path "/home/deploy/shared/unicorn-stderr.log"
stdout_path "/home/deploy/shared/unicorn-stdout.log"

before_fork do |server, worker|
  old_pid = '/home/deploy/shared/unicorn.pid.oldbin'
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end


after_fork do |server, worker|
# Here we are establishing the connection after forking worker
# processes
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end