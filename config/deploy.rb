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
end

after 'deploy:publishing', 'deploy:restart'