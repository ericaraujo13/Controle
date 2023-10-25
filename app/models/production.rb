class Production < ApplicationRecord
  belongs_to :product
  has_one :user, through: :product
  accepts_nested_attributes_for :product
  after_create_commit :update_charts

  validates :product_id, presence: true
  validates :quantity, presence: true
  validates :date_time, presence: true

  private

  def update_charts
    broadcast_replace_to("productions_charts_channel#{user.id}", partial: 'home/charts/productions/chart',
                                                        locals: {user: user},
                                                        target: 'production_chart'
                                                        )
  end
end
