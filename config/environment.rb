require 'sinatra'
require 'sinatra/activerecord'
require 'carrierwave'
require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.root = File.expand_path('../../public', __FILE__)
end

require_relative '../uploaders/image_uploader'

register Sinatra::ActiveRecordExtension

enable :sessions

# configure do
#   set :sessions,
#       key: 'mi_app.session',
#       expire_after: 3600,
#       secret: "clave_muy_segura_y_larga_para_sesiones_que_cumpla_el_minimo_de_64_bytes",
#       httponly: true,
#       secure:false
# end

require_relative '../app/dbs/connection'
require_relative '../app/home/infrastructure/controller/home_controller'
require_relative '../app/category/infrastructure/controller/category_controller'
#product
require_relative '../app/product/infrastructure/controller/admin_product_controller'
require_relative '../app/product/infrastructure/controller/product_controller'
require_relative '../app/product/application/product_service'
require_relative '../app/product/infrastructure/persistence/repositories/product_repository_pg'
#app/product/infrastructure/persistence/repositories

# repositorios
product_repository = ProductRepository_pg.new
# servicios
product_service = ProductService.new(product_repository)

#auth
require_relative '../app/auth/infrastructure/controller/auth_controller'
require_relative '../app/auth/application/auth_service'
require_relative '../app/auth/infrastructure/persistence/repositories/auth_repository_pg'

auth_repository = AuthRepository_pg.new
auth_service = AuthService.new(auth_repository)

# controladores
use HomeController
use CategoryController
use AdminProductController, product_service
use ProductController, product_service #injeccion dependencias
use AuthController, auth_service
