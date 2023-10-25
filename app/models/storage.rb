class Storage < ApplicationRecord
  belongs_to :production
  belongs_to :user, through: :production

end
