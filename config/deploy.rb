# Define the name of the application
set :application, 'epmargin'

# Define where can Capistrano access the source repository
# set :repo_url, 'https://github.com/[user name]/[application nam
set :ssh_options, {
  forward_agent: true,
  paranoid: true,
  keys: "~/.ssh/id_rsa"
}
# https://jenniffer54@gmail.com:j@bitbucket.org:jquiu/impala.git
set :scm, :git
set :repo_url, 'git@bitbucket.org:jquiu/impala.git'
set :branch, 'master'
# Define where to put your application code
set :deploy_to, "/var/www/html/impala/"


set :pty, true

set :format, :pretty

set :copy_cache, true
set :deploy_via, :remote_cache
set :copy_strategy, :export
set :use_sudo, true
set :copy_exclude, [".git", ".DS_Store", ".gitignore", ".gitmodules", "Capfile", "config/deploy.rb"]
set :linked_dirs, %w{bin log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
namespace :deploy do
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
    	execute :touch, release_path.join('tmp/restart.txt')
  	end
  end
  task :symlink_uploads do
  	on roles(:app), in: :sequence, wait: 5 do
    	run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
    end
  end
end

after 'deploy:publishing', 'deploy:restart'
