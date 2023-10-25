class StoragesController < ApplicationController
  def index
    sql = "products.name, sum(productions.quantity) - (select sum(transactions.quantity) from transactions where transactions.product_id = products.id) as total"
    @products = current_user.products.left_joins(:productions).select(sql).group(:id)
  end
end
