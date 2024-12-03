# require 'active_record'
# require 'rake'

# namespace :db do
#   desc 'Migrate the database'
#   task :migrate => :environment do
#     ActiveRecord::Base.establish_connection(
#       adapter: 'postgresql',
#       host: 'test-fiis-db-1',
#       database: 'compufiis_development',
#       username: 'cristian',
#       password: 'cristian'
#     )

#     migration_context = ActiveRecord::MigrationContext.new('app/dbs/migrate', ActiveRecord::SchemaMigration)
#     migration_context.migrate
#   end

#   task :environment do

#   end
# end

require 'sinatra/activerecord/rake'
require './main'  # tu archivo principal de la aplicación