APP_PATH = "/var/www/simple-sinatra-app"
working_directory APP_PATH
timeout 30
worker_processes 2
listen "/tmp/.unicorn.sock", :backlog => 64
pid "/tmp/unicorn.pid"
stderr_path "/var/log/unicorn/unicorn.stderr.log"
stdout_path "/var/log/unicorn/unicorn.stdout.log"
