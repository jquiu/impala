set :application, 'app_name'
set :repo_url, 'git@github.com:jquiu/impala.git'
 
# Default branch is :master
set :branch, 'master'
 
# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/html/impala/"
# Default value for :scm is :git
# set :scm, :git
 
# Default value for :format is :pretty
# set :format, :pretty
 
# Default value for :log_level is :debug
# set :log_level, :debug
 
# Default value for :pty is false
set :pty, true
 
# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml')
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
 
# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
 
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
 
# Default value for keep_releases is 5
set :keep_releases, 5
 
set :passenger_restart_command, 'rvmsudo passenger-config restart-app'
 
# Set rvm and ruby version if you use specific ones
#set :rvm_ruby_version, '2.0.0@gemset_name'
 
namespace :deploy do
  task :symlink_uploads do
    on roles(:app), in: :sequence, wait: 5 do
      run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
    end
  end
 
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      within release_path do
        execute :rake, 'cache:clear'
      end
    end
  end
end 
