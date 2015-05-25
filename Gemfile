source 'https://rubygems.org'

gem 'sinatra', '~> 1.4.6'
gem 'sinatra-contrib', '~> 1.4.2'
gem 'activesupport', '~> 4.2.0'
gem 'activemodel', '~> 4.2.0'
gem 'activerecord', '~> 4.2.0'
gem 'protected_attributes', '~> 1.0.8'
gem 'apartment', '~> 1.0.1'
gem 'tilt-jbuilder'
gem 'rake', '~> 10.1.0'
gem 'pg', '~> 0.15'
gem 'unicorn', '~> 4.6.2'
gem 'will_paginate'

gem 'data_store_client', git: 'git@github.com:vdizzle/data_store_client.git', branch: 'develop'

group :development do
  gem 'tux', '~> 0.3.0'
  gem 'foreman'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'factory_girl'
  gem 'shoulda-matchers'
  gem 'database_cleaner', '~> 1.4.1'
  gem 'json_spec'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
end

group :development, :test do
  gem 'debugger'
  gem 'pry-debugger'
end
