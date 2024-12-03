require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'test-fiis-db-1',
  database: 'compufiis_development',
  username: 'cristian',
  password: 'cristian'
)

puts 'Conexión a la base de datos establecida correctamente'