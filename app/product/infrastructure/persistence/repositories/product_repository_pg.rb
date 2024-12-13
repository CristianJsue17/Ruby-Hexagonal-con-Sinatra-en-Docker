require_relative '../entities/product'
require_relative '../../../domain/ports/output/product_repository_interface'

class ProductRepository_pg < ProductRepository
    def initialize
        @products = {}
    end

    # def save(product)
    #     @products[product.id] = product
    # end
    def get_all_products
        puts "get_all_products en mi repositorio"
      Infrastructure::Persistence::Entities::Product.all
    end

    def find_by_id(id)
        Infrastructure::Persistence::Entities::Product.find(id)
    end

    def find_by_category(category)
        Infrastructure::Persistence::Entities::Product.where(category: category)
    end

    def related_products(category,except)
        Infrastructure::Persistence::Entities::Product.where(category: category).where.not(id: except).limit(4)
    end

    def create(name, description, price, category, brand, stock, material, dimension, peso, color,caracteristicas,image)
        Infrastructure::Persistence::Entities::Product.create(name: name, description: description, price: price, category: category, brand: brand, stock: stock, material: material, dimension: dimension, peso: peso, color: color,caracteristicas: caracteristicas, image: image)
    end

    # def update(id, name, description, price, category, brand, stock, material, dimension, peso, color,caracteristicas,image)
    #     product = Infrastructure::Persistence::Entities::Product.find(id)
    #     product.update(name: name, description: description, price: price, category: category, brand: brand, stock: stock, material: material, dimension: dimension, peso: peso, color: color,caracteristicas: caracteristicas, image: image)
    # end
    def update(id,product)
        product_to_update = Infrastructure::Persistence::Entities::Product.find(id)
        product_to_update.update(product)
    end

    def get_product_group_by(category)
        Infrastructure::Persistence::Entities::Product.all.group_by(&:category)
    end

    def delete_product(id)
        Infrastructure::Persistence::Entities::Product.find(id).destroy
    end
end