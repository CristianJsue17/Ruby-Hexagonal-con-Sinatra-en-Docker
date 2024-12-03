require 'sinatra/base'
require 'sinatra/json'
# require_relative '../../application/product_service'
# require_relative '../persistence/repositories/product_repository_pg'

class AuthController < Sinatra::Base
    
    configure do
        set :module_views, File.expand_path('../../views', __FILE__)
        # set :common_views, File.expand_path('../../../../common/views', __FILE__)
    end

    helpers do
      def find_template(views, name, engine, &block)
        super(settings.module_views, name, engine, &block) 
        # super(settings.common_views, name, engine, &block)
      end
    end

    def initialize(app = nil,service)
        super(app)
        @service = service
    end


    get '/login/new' do
        currentSession = session[:user_id]
        # si la sesion ya esta iniciada
        # redirigir a la pagina /admin/products/create/new
        if currentSession
            redirect '/admin/products/create/new'
        end
        erb:new
    end

    post '/login' do
        username = params[:username]
        password = params[:password]
        user = @service.login(username,password)      
        if user
            # session[:user] = user
            session[:user_id] = user[:id]
            redirect '/admin/products/create/new'
        else
            redirect '/login/new'
        end
    end

    get '/login/test' do
        user = session[:user_id]
        json({message: user})
    end
end