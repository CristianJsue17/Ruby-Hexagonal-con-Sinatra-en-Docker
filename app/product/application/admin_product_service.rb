require_relative '../domain/ports/input/admin_product_service_interface'
class AdminProductService < AdminProductServiceInterface
  def initialize(repository)
    @repository = repository
  end

  # def get_all_products
  #   @repository.get_all_products
  # end
  
  def get_product_by_id(id)
    #admin
    @repository.find_by_id(id)
  end

  def create_product(name, description, price, category, brand, stock, material, dimension, peso, color,caracteristicas,image)
    #admin
    @repository.create(name, description, price, category, brand, stock, material, dimension, peso, color,caracteristicas,image)
  end

  # def update_product(id, name, description, price, category, brand, stock, material, dimension, peso, color,caracteristicas,image)
  #   @repository.update(id, name, description, price, category, brand, stock, material, dimension, peso, color,caracteristicas,image)
  # end
  def update_product(id,product)
    #admin
    @repository.update(id,product)
  end

  def get_product_group_by(category)
    #admin
    @repository.get_product_group_by(category)
  end

  def delete_product(id)
    #admin
    @repository.delete(id)
  end

end