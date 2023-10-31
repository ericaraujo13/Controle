class AddUserToFinances < ActiveRecord::Migration[7.0]
  def change
    add_reference :finances, :user, foreign_key: true
  end
end
