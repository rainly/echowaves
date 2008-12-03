set :application, "echowaves"

default_run_options[:pty] = true

# ssh_options[:forward_agent] = true
set :branch, "master"
set :deploy_via, :remote_cache
set :runner, nil
# set :git_shallow_clone, 1

# set :deploy_to, "/u/apps/#{application}"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# this is a public repository, is used in readonly mode. The only way to change something in prod is through doing another prod deploy
set :repository,  "git://github.com/dmitryame/echowaves.git" 
set :scm, "git"

#set :mongrel_conf, "#{deploy_to}/current/config/mongrel_cluster.yml"

# set :scm_passphrase, "p@ssw0rd" #This is your custom users password
set :user, "deployer"

role :app, "echowaves.com"
role :web, "echowaves.com"
role :db,  "echowaves.com", :primary => true


namespace :deploy do
  
  task :copy_prod_configuration do
    run "cp /u/config/#{application}/database.yml #{release_path}/config/"
#    run "cp /u/config/#{application}/production.rb #{release_path}/config/environments/"
    run "cp /u/config/#{application}/environment.rb #{release_path}/config/"
    run "cp /u/config/#{application}/site_keys.rb #{release_path}/config/initializers/"
    run "ln -nfs /vol/sphinx #{release_path}/db/sphinx"    
    run "cd #{deploy_to}/current; /usr/bin/rake thinking_sphinx:index  RAILS_ENV=production"
    run "cd #{deploy_to}/current; /usr/bin/rake thinking_sphinx:start  RAILS_ENV=production"
    run "ln -nfs /vol/attachments #{release_path}/public/attachments"
  end
  
  after "deploy:update_code", "deploy:copy_prod_configuration"
end
