class Storage < ApplicationRecord
  belongs_to :production
  has_one :user, through: :production

end
