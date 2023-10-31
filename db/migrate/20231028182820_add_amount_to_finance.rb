class AddAmountToFinance < ActiveRecord::Migration[7.0]
  def change
    add_column :finances, :amount, :decimal
  end
end
