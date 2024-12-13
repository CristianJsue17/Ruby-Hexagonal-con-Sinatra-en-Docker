
require_relative '../domain/ports/input/category_service_interface'
require_relative '../domain/category'
require 'net/http' 
require 'json'

class CategoryService < CategoryServiceInterface
  def initialize()
  end
  def get_products_by_category(cat)
       category = Category.new
       if category.validateCategory(cat)
         uri = URI("http://localhost:4567/products/#{cat}")
         response = Net::HTTP.get(uri)
         @products = JSON.parse(response)
       else
         @products = nil
         # @message = "Invalid category"
       end
    end
end