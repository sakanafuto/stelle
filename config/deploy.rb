lock "3.5.0"

set :application, "stelle"
set :repo_url, "git@github.com:sakanafuto/stelle.git"

set :deploy_to, "/var/www/stelle"

set :scm, :git
set :format, :pretty
set :log_level, :debug

set :pty, true

set :keep_releases, 5

set :rbenv_type, :user # :system or :user
set :rbenv_ruby, '2.6.5'

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# set :linked_files, %w{config/database.yml}
set :linked_files, fetch(:linked_files, []).push('config/master.key')

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

set :bundle_jobs, 4


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app) do
      invoke 'unicorn:restart'
    end
  end
end

# linked_filesで使用するファイルをアップロードするタスクは、deployが行われる前に実行する必要がある
before 'deploy:starting', 'deploy:upload'
# Capistrano 3.1.0 からデフォルトで deploy:restart タスクが呼ばれなくなったので、ここに以下の1行を書く必要がある
after 'deploy:publishing', 'deploy:restart'