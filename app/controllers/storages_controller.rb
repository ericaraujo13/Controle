class StoragesController < ApplicationController
  def index
    @products = Product.left_joins(:productions).select("products.*, sum(productions.quantity) as total").group(:id)
  end
end
