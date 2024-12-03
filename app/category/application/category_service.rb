# require_relative '../domain/product'
# require_relative '../domain/product_repository'
require 'net/http' 
require 'json'

class CategoryService
  def get_products_by_category(category)
       uri = URI("http://localhost:4567/products/#{category}")
       response = Net::HTTP.get(uri)
       @products = JSON.parse(response)
    return @products
  end
end