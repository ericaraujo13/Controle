class Transaction < ApplicationRecord
  belongs_to :product
  has_one :user, through: :product
  after_create_commit :update_charts

  validates :product_id, presence: true
  validates :quantity, presence: true
  validates :amount, presence: true
  validates :date_time, presence: true

  private

  def update_charts
    broadcast_replace_to("transactions_charts_channel#{user.id}", partial: 'home/charts/days/chart',
                                                        locals: {user: user},
                                                        target: 'sells_chart'
                                                        )
  end
end
