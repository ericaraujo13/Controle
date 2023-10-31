class CreateFinances < ActiveRecord::Migration[7.0]
  def change
    create_table :finances do |t|
      t.integer :transaction_type
      t.string :description

      t.timestamps
    end
  end
end
