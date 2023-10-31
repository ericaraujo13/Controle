class Finance < ApplicationRecord
  belongs_to :user
  
  validates :description, presence: true
  enum transaction_type: [ :entrada, :saida ]
end
