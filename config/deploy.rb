set :application, 'SpartanRunningClub'
set :repository, 'git@github.com:ajm188/SpartanRunningClub.git'

set :deploy_to, '/home/andrew/SpartanRunningClub'
set :deploy_via, :remote_cache

set :scm, :git
set :branch, :master

set :user, 'andrew'

set :use_sudo, false
set :rails_env, 'production'

set :keep_releases, 3

default_run_options[:pty] = true

server 'running.case.edu', :app, :web, :db, primary: true

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
    task :start do ; end
    task :stop do ; end

    desc "Restart the application"
    task :restart, :roles => :app, :except => { :no_release => true } do
        run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    end

    desc "Create symlinks"
    task :create_symlinks do
        run "#{try_sudo} ln -s /home/andrew/SpartanRunningClub /var/www"
    end
end

#after 'deploy', 'bootstrap:admin'
after 'deploy', 'deploy:create_symlinks'
after 'deploy', 'deploy:restart'