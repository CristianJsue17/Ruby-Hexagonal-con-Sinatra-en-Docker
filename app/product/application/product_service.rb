# require_relative '../domain/auth'
require_relative '../domain/ports/input/product_service_interface'
class ProductService < ProductServiceInterface
  def initialize(repository)
    @repository = repository
  end

  def get_all_products
    @repository.get_all_products
  end

  def get_product_by_id(id)
    @repository.find_by_id(id)
  end

  def find_by_category(category)
    @repository.find_by_category(category)
  end

  def get_related_products(category, except)
    @repository.related_products(category,except)
  end

  def create_product(name, description, price, category, brand, stock, material, dimension, peso, color,caracteristicas,image)
    @repository.create(name, description, price, category, brand, stock, material, dimension, peso, color,caracteristicas,image)
  end

  def update_product(id,product)
    @repository.update(id,product)
  end

  def get_product_group_by(category)
    @repository.get_product_group_by(category)
  end
  def delete_product(id)
    #admin
    @repository.delete_product(id)
  end

end