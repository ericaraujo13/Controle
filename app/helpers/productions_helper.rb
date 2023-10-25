module ProductionsHelper
  def productions_per_day
    days = week_range

    day_range = days.map do |day|
      [day.strftime("%A"), day]
    end

    day_range.each_with_object([]) do |a_day, total|
      week_day, day = a_day
      total << [week_day, Production.joins(:product).where(date_time: day..day.end_of_day, product: {user: current_user}).sum(:quantity)]
    end
  end

  def week_range
    (Date.today.beginning_of_week..Date.today.end_of_week)
  end
end
