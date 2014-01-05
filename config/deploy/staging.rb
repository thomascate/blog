set :stage, :staging
set :branch, 'master'
roles = 'web'


server 'rails.luddite.nl', user: 'deploy', roles: 'web'