class Product < ApplicationRecord
  has_many :productions


  def sum_storage
   product_quantity = Product.left_joins(:productions).select("products.*, sum(productions.quantity) as total").group(:id)
   total_product = product_quantity.total
  end
end
