set :user, 'clonclient'
set :application, 'musafisha'

set :repo_url, 'git@rscz.ru:rocket-station/pricheson.git'
set :branch, ENV["REVISION"] || "master"
#set :default_env, {
#  'REDIS_URL' => 'redis://localhost:6379/1'
#}

set :deploy_to, -> { "/home/#{fetch(:user)}/app" }

set :puma_state, -> { File.join(shared_path, 'tmp', 'puma', 'state') }
set :puma_pid, -> { File.join(shared_path, 'tmp', 'puma', 'pid') }
set :puma_conf, -> { File.join(current_path, 'config', 'puma.rb') }

#set :sidekiq_concurrency, 5 # кол-во тредов на процесс, синхронизировано с pool в active_record

Rake::Task["puma:check"].clear
Rake::Task["puma:config"].clear
namespace :puma do
  task :check do
    puts 'override'
  end
  task :config do
  end
end

namespace :deploy do
  desc "webpack"
  task :webpack do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "webpack:compile"
        end
      end
    end
  end
end

after "deploy:updated", "deploy:webpack"

set :keep_releases, 10

set :use_sudo, :false

#set :linked_files, %w(config/database.yml config/secrets.yml public/robots.txt public/sitemap.xml config/puma.rb)
set :linked_files, %w(config/database.yml config/secrets.yml)
set :linked_dirs, %w(log tmp vendor/bundle public/assets public/system public/webpack public/uploads node_modules)


