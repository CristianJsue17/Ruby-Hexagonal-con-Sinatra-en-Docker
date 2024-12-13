require 'sinatra/base'
require 'sinatra/json'
# require_relative '../../application/product_service'
# require_relative '../persistence/repositories/product_repository_pg'

class AdminProductController < Sinatra::Base
    
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

    def initialize(app = nil,service)
        super(app)
        # repository = ProductRepository_pg.new
        # @service = ProductService.new(repository)
        @service = service
    end
    

    get '/admin/products/create/new' do
        # admin vista
        @products_by_category = @service.get_product_group_by('category')
        if request.cookies['confirmation_message']
            @confirmation_message = request.cookies['confirmation_message']
            response.delete_cookie('confirmation_message',path: '/')
        end
        erb :'admin/new', layout: :'layouts/application'
    end

    post '/admin/products/create' do
        # admin backend
        name = params[:product][:name]
        description = params[:product][:description]
        price = params[:product][:price]
        category = params[:product][:category]
        brand = params[:product][:brand]
        stock = params[:product][:stock]
        material = params[:product][:material]
        dimension = params[:product][:dimension]
        peso = params[:product][:peso]
        color = params[:product][:color]
        caracteristicas = params[:product][:caracteristicas]
        image = params[:product][:image][:tempfile]
        @service.create_product(name, description, price, category, brand, stock, material, dimension, peso, color, caracteristicas,image)
        response.set_cookie('confirmation_message',{
            value: 'Product created successfully',
            path: '/',
            max_age: '3600'
        })
        redirect '/admin/products/create/new'
    end

    get '/admin/products/edit/:id' do
        # admin vista
        id = params[:id]
        @product = @service.get_product_by_id(id)
        if request.cookies['confirmation_message']
            @confirmation_message = request.cookies['confirmation_message']
            response.delete_cookie('confirmation_message',path: '/')
        end
        erb :'admin/edit'
    end

    post '/admin/products/update/:id' do
        # admin backend
        id = params[:id]
        @service.update_product(id,params[:product])
        response.set_cookie('confirmation_message',{
            value: 'Product updated successfully',
            path: '/',
            max_age: '3600'
        })
        redirect "/admin/products/edit/#{id}"
    end

    post '/admin/products/delete/:id' do
        # admin backend
        id = params[:id]
        @service.delete_product(id)
        json status: 'ok', message: 'Product deleted successfully'
    end

    get '/auth/logout' do
        session.clear # Limpia todos los datos de la sesión
        redirect '/' # Redirige al home
      end
end