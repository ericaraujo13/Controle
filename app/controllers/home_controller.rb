class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @productions = Production.joins(:product).where(date_time: week_range, product: {user: current_user}).limit(5)
    @transactions = Transaction.joins(:product).where(date_time: week_range, product: {user: current_user}).limit(5)
  end

  def week_range
    (start_week = Time.current.beginning_of_week...end_of_week = Time.current.end_of_week)
  end
end
