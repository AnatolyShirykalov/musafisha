set :stage, :production
set :rails_env, :production

server 'ec2-52-41-205-115.us-west-2.compute.amazonaws.com', user: 'clonclient', roles: %w{web app db}
