require 'active_record'

namespace :db do
  task :configuration => :environment do
    require 'yaml'
    require 'erb'
    yaml = ERB.new(File.read('config/database.yml')).result
    @config = YAML.load(yaml).fetch(ENV['RACK'])
    puts "Configuration - #{@config}"
  end

  task :configure_connection => :configuration do
    ActiveRecord::Base.establish_connection(@config)
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  desc 'Create Database'
  task :create => :configuration do
    ActiveRecord::Base.establish_connection @config.merge(
      'database' => 'postgres')
    ActiveRecord::Base.connection.create_database(@config['database'])
    ActiveRecord::Base.establish_connection(@config)
  end

  desc 'Migrate Database'
  task :migrate => :configure_connection do
    ActiveRecord::Migrator.migrate('db/migrate')
    Rake::Task['db:schema:dump'].invoke
  end

  desc 'Drop Database'
  task :drop => :configure_connection do
    ActiveRecord::Base.establish_connection(@config.merge(
      'database' => 'postgres'))
    ActiveRecord::Base.connection.drop_database(@config['database'])
  end

  namespace :schema do
    desc '(Re)create DB from existing schema'
    task :load => 'db:configuration' do
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      load 'db/schema.rb'
    end

    desc 'Export current DB to schema.rb'
    task :dump => :configure_connection do
      ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection,
                                      File.open('db/schema.rb', 'w'))
    end
  end

  desc 'Truncate all tables'
  task :truncate => :configure_connection do
    conn = ActiveRecord::Base.connection
    tables = conn.execute("show tables").map { |r| r[0] }
    puts tables
    tables.delete "schema_migrations"
    tables.each { |t| conn.execute("TRUNCATE #{t}") }
  end

  desc 'Rollback Database'
  task :rollback => :configure_connection do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::Migrator.rollback 'db/migrate', step
    Rake::Task['db:schema:dump'].invoke
  end

  desc 'Migration for test'
  namespace :test do
    desc 'Prepare for test'
    task :prepare do
      ENV['RACK'] = 'test'
      Rake::Task['db:configuration'].invoke
      Rake::Task['db:schema:load'].invoke
    end
  end
end

