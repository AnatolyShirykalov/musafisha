# frozen_string_literal: true

set :stage, :production
set :rails_env, :production
set :user, 'vsobake'
set :application, 'vsobake'

server 'vsobake.ru', user: 'vsobake', roles: %w[web app db]
