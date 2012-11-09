require 'rake'
require 'rspec/core/rake_task'
require_relative 'db/config'
require_relative 'lib/group_girl'
# require_relative 'lib/students_importer'
#
#
desc "create the database"
task "db:create" do
  touch 'db/group_hug.sqlite3'
end
#
desc "drop the database"
task "db:drop" do
  rm_f 'db/group_hug.sqlite3'
end
#
desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end
#
desc "populate the database with GroupHug data"
task "db:populate" do
  GroupGirl.get_confessions
end
#
desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end
#
desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

task :default  => :specs
