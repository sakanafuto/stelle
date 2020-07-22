lock "3.5.0"

set :application, "stelle"
set :repo_url, "git@github.com:sakanafuto/stelle.git"

set :deploy_to, "/var/www/stelle"

set :scm, :git
set :format, :pretty
set :log_level, :debug

set :pty, true

set :keep_releases, 5

set :rbenv_type, :user
set :rbenv_ruby, '2.6.5'

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

set :linked_files, fetch(:linked_files, []).push('config/master.key')

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'var/socks', 'vendor/bundle', 'public/system')

set :bundle_jobs, 4


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app) do
      invoke 'unicorn:restart'
    end
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
end

# Capistrano 3.1.0 からデフォルトで deploy:restart タスクが呼ばれなくなったので、ここに以下の1行を書く必要がある
after 'deploy:publishing', 'deploy:restart'