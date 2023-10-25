class Transaction < ApplicationRecord
  belongs_to :product
  has_one :user, through: :product
  after_create_commit :update_charts

  private

  def update_charts
    broadcast_replace_to("transactions_charts_channel#{user.id}", partial: 'home/charts/days/chart',
                                                        locals: {user: user},
                                                        target: 'sells_chart'
                                                        )
  end
end
