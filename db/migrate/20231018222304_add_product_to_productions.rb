class AddProductToProductions < ActiveRecord::Migration[7.0]
  def change
    add_reference :productions, :product, foreign_key: true
  end
end
