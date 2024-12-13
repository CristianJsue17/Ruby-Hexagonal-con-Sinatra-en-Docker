# require_relative '../domain/product'
# require_relative '../domain/product_repository'

class AuthService
  def initialize(repository)
    @repository = repository
  end

  # def create_product(id:, name:, description:, price:)
  #   product = Domain::Product.new(id: id, name: name, description: description, price: price)
  #   @repository.save(product)
  # end
  def login(username, password)
    @repository.login(username, password)
  end
end