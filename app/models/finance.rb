class Finance < ApplicationRecord
  belongs_to :user
  
  validates :description, presence: true
  validates :transaction_type, presence: true
  validates :amount, presence: true
  enum transaction_type: [ :entrada, :saida ]
end
