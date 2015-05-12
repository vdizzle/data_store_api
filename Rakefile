task :environment do
  require_relative 'app'
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

Dir['./lib/tasks/*.rake'].each do |rakefile|
  load(File.expand_path(rakefile))
end
