require 'sinatra'
require 'sinatra/base'
require_relative '../../application/home_service'

# puts "views antes de definir el controlador: #{settings.views.inspect}"
class HomeController < Sinatra::Base
    
    configure do
        set :module_views, File.expand_path('../../views', __FILE__)
        set :common_views, File.expand_path('../../../../common/views', __FILE__)
    end

    helpers do
      def find_template(views, name, engine, &block)
        super(settings.module_views, name, engine, &block) 
        super(settings.common_views, name, engine, &block)
      end
    end

    def initialize(app = nil)
      super(app)
      @service = HomeService.new
    end

    get '/' do
        @random_laptops = @service.get_products_by_category("laptops")
        @random_computers = @service.get_products_by_category("computadoras")[0]
        @random_cellphones = @service.get_products_by_category("celulares")
        @random_accessory = @service.get_products_by_category("accesorios")[0]
        puts "laptos: #{@random_laptops}"      
        erb :index, layout: :'layouts/application'
    end

    get '/not_found' do
      "Not found"
    end
    
end