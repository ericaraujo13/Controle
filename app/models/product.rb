class Product < ApplicationRecord
  belongs_to :user
  has_many :productions

  validates :name, presence: true

  def sum_storage
   product_quantity = Product.left_joins(:productions).select("products.*, sum(productions.quantity) as total").group(:id)
   total_product = product_quantity.total
  end
end
