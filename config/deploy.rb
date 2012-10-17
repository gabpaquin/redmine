require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/check"
load "config/recipes/postgresql"
load "config/recipes/rbenv"

server "192.168.6.127", :web, :app, :db, primary: true

set :git_enable_submodules, 1

set :application, "redmine"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
# this keeps a copy of the Git repository on the server cache 
# so that it can be updated without having to clone the 
# repository each time we deploy the application
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:Gabey/redmine.git"
set :branch, "deploy"

# option so that the password prompt works
default_run_options[:pty] = true
# authorizes the server to access the Git repository 
# so that we don’t have to add a deploy key to Github
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" #keep only the last 5 releases