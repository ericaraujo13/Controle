class AddProductToProductions < ActiveRecord::Migration[7.0]
  def change
    add_reference :productions, :product, null: false, foreign_key: true
  end
end
