require 'net/http' 
require 'json'

class HomeService
  # def initialize(repository)
  #   @repository = repository
  # end

  # def create_product(id:, name:, description:, price:)
  #   product = Domain::Product.new(id: id, name: name, description: description, price: price)
  #   @repository.save(product)
  # end

  # def find_product(id)
  #   @repository.find_by_id(id)
  # end
  def get_products_by_category(category)
       uri = URI("http://localhost:4567/products/#{category}")
       response = Net::HTTP.get(uri)
       @products = JSON.parse(response)
    return @products
  end
end


#end