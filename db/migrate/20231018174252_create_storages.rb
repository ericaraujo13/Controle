class CreateStorages < ActiveRecord::Migration[7.0]
  def change
    create_table :storages do |t|
      t.references :production, null: false, foreign_key: true

      t.timestamps
    end
  end
end
