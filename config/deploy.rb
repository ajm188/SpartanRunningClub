set :application, 'SpartanRunningClub'
set :repository, 'git@github.com:ajm188/SpartanRunningClub.git'

set :deploy_to, '/var/www/SpartanRunningClub'
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
    task :restart, :roles => :app, :except => { :no_release => true } do
        run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    end
end

#after 'deploy', 'bootstrap:admin'
after 'deploy', 'deploy:restart'