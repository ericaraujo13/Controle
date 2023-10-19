class CreateProductions < ActiveRecord::Migration[7.0]
  def change
    create_table :productions do |t|
      t.string :description
      t.numeric :quantity
      t.date :date_time

      t.timestamps
    end
  end
end
