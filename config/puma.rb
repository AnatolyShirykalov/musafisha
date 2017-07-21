# Min and Max threads per worker
threads 1, 3

current_dir = File.expand_path("../..", __FILE__)
base_dir = File.expand_path("../../..", __FILE__)


# rackup DefaultRackup

# Default to production
rails_env = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || "development"
environment rails_env

if rails_env == 'development'
  Puma.windows? { workers 1 }
  bind 'tcp://0.0.0.0:1290'
else
  # https://github.com/seuros/capistrano-puma/blob/642d141ee502546bd5a43a76cd9f6766dc0fcc7a/lib/capistrano/templates/puma.rb.erb#L25
  prune_bundler
  preload_app!
  # Change to match your CPU core count
  workers 1
  shared_dir = "#{base_dir}/shared"
  # Set up socket location
  #bind 'tcp://0.0.0.0:4000'
  bind "unix://#{shared_dir}/tmp/puma/socket"
  # Logging
  stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true
  # Set master PID and state locations
  pidfile "#{shared_dir}/tmp/puma/pid"
  state_path "#{shared_dir}/tmp/puma/state"
  activate_control_app
  on_restart do
    puts 'Refreshing Gemfile'
    ENV["BUNDLE_GEMFILE"] = "#{current_dir}/Gemfile" unless rails_env == 'development'
  end
  
  on_worker_boot do
    require "active_record"
    ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
    ActiveRecord::Base.establish_connection(YAML.load_file("#{base_dir}/current/config/database.yml")[rails_env])
  end
end

