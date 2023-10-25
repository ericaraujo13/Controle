class Transaction < ApplicationRecord
  belongs_to :product
  has_one :user, through: :product
end
