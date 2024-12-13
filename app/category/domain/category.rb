class Category
  PERMITTED_CATEGORIES = ["laptops", "celulares", "computadoras"]

  def validateCategory(category)
    PERMITTED_CATEGORIES.include?(category)
  end
end