set :application, 'blog'
set :repo_url, 'git@github.com:thomascate/blog.git'
set :deploy_to, '/home/deploy'
set :deploy_via, :remote_cache
set :use_sudo, false
set :rbenv_ruby, '2.0.0-p353'
set :scm, :git
set :format, :pretty
set :log_level, :debug
set :keep_releases, 5

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:web) do
      execute "sh /home/deploy/current/config/unicorn_restart"
    end
  end

  after :finishing, 'deploy:cleanup'
end