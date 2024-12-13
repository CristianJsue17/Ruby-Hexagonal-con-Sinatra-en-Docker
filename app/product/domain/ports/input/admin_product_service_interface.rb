class AdminProductServiceInterface

  def get_product_by_id(id)
    raise NotImplementedError
  end

  def create_product(name, description, price, category, brand, stock, material, dimension, peso, color,caracteristicas,image)
    raise NotImplementedError
  end

  def update_product(id,product)
    raise NotImplementedError
  end

  def get_product_group_by(category)
    raise NotImplementedError
  end

  def delete_product(id)
    raise NotImplementedError
  end

end