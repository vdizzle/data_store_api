worker_processes 2
preload_app true
timeout 300

listen File.expand_path('../../tmp/sockets/unicorn.sock', __FILE__), :backlog => 64
pid File.expand_path('../../tmp/pids/unicorn.pid', __FILE__)

stderr_path './log/unicorn.error.log'
stdout_path './log/unicorn.out.log'
