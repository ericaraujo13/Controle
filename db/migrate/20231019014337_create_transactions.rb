class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :product, null: false, foreign_key: true
      t.numeric :quantity
      t.numeric :amount
      t.date :date_time

      t.timestamps
    end
  end
end
