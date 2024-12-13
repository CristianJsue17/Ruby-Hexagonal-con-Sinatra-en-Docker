require_relative 'config/environment'


set :public_folder, 'public'
set :bind, '0.0.0.0'
set :port, 4567

if __FILE__ == $0
  Sinatra::Application.run!
end
