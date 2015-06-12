ENV['RACK_ENV'] ||= 'development'
ENV['APP_ROOT'] ||= File.expand_path(File.dirname(__FILE__))

$LOAD_PATH.unshift(File.join(ENV['APP_ROOT'], 'lib'))

require 'bundler'
Bundler.setup

require 'active_support'
require 'active_support/core_ext'
require 'erb'
require 'i18n'
require 'sinatra/base'
require 'sinatra/jbuilder'
require 'sinatra/json'
require 'yaml'

Dir["config/initializers/*.rb"].sort.each do |initializer_file|
  require(initializer_file)
end
