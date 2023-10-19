class HomeController < ApplicationController
  def index
    @productions = Production.where(date_time: week_range)
    @transactions = Transaction.where(date_time: week_range)
  end

  def week_range
    (start_week = Time.current.beginning_of_week...end_of_week = Time.current.end_of_week)
  end
end
