require 'sinatra/base'
require 'sinatra/json'

class AdminController < Sinatra::Base
    
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

    get '/products/index' do
        # API
        @all_products = @service.get_all_products
        json @all_products
    end
    
    get '/products/show/:id' do
        # public vista
        id = params[:id]
        @product = @service.get_product_by_id(id)
        except = @product.id
        # @related_products = Product.where(category: @product.category).where.not(id: @product.id).limit(4)
        @related_products = @service.get_related_products(@product.category,except)
        erb :show, layout: :'layouts/application'

    end
    
    get '/products/:category' do
        #public vista
        param = params[:category]
        puts "productos por category: #{param}"
        @category_products = @service.find_by_category(param)
        json @category_products
    end

    get '/products/create/new' do
        # admin vista
        @products_by_category = @service.get_product_group_by('category')
        puts "productos por category: #{@products_by_category.inspect}"
        erb :new, layout: :'layouts/application'
    end

    post '/products/create' do
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
        redirect '/products/index'
    end

    get '/products/edit/:id' do
        # admin vista
        id = params[:id]
        @product = @service.get_product_by_id(id)
        erb :edit
    end

    post '/products/update/:id' do
        # admin backend
        id = params[:id]
        puts " params: #{params[:product]}"
        @service.update_product(id,params[:product])
        "hello world"
    end
end