class Production < ApplicationRecord
  belongs_to :product
  has_one :user, through: :product
  accepts_nested_attributes_for :product

  validates :product_id, presence: true
  validates :quantity, presence: true
  validates :date_time, presence: true
end
