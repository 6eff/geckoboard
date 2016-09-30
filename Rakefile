%w{ bundler find rake/testtask}.each { |lib| require lib }

task :default => :spec

Rake::TestTask.new(:spec) do |t|
  t.test_files = FileList['spec/*_spec.rb']
end

namespace :db do
  desc "Run all migrations in db/migrate"
  task :migrate => :connect do
    Sequel.extension(:migration)
    Sequel::Migrator.apply(DB, "db/migrate")
  end

  desc 'Perform migration reset (full erase and migration up).'
    task :reset => :connect do
      Sequel.extension(:migration)
      Sequel::Migrator.run(DB, 'db/migrate', :target => 0)
      Sequel::Migrator.run(DB, 'db/migrate')
      puts '*** db:migrate:reset executed ***'
    end

  task :environment do
    require 'sequel'
    ENV['RACK_ENV'] ||= 'development'
  end

  task :connect => :environment do
    require "./config/initializers/database"
  end
end
