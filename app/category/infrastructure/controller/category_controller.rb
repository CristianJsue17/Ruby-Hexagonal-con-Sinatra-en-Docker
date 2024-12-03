require 'sinatra/base'
require_relative '../../application/category_service'
class CategoryController < Sinatra::Base
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
      @service = CategoryService.new
    end

    get '/category/:type' do
        param = params[:type]
        @products = @service.get_products_by_category(param)
        erb :index, layout: :'layouts/application'
    end  
end