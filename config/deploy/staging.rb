set :stage, :staging
set :branch, 'master'
roles = ['app', 'web']


server 'rails.luddite.nl', user: 'deploy', roles: roles