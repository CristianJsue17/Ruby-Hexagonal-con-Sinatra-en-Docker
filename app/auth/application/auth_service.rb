require_relative '../domain/auth'
require_relative '../domain/ports/input/auth_service_interface'
# require_relative '../domain/product_repository'

class AuthService < AuthServiceInterface
  def initialize(repository)
    @repository = repository
    @auth = Auth.new
  end

  def login(username, password)
    sanitizedCredentials = @auth.login(username, password)
    if sanitizedCredentials
      return @repository.login(sanitizedCredentials[:email], sanitizedCredentials[:password])
    end
    nil
  end
end