module BalanceHelper
  def next_12_months
    sql = "select date_part('month', date_time) as month_name, count(*) as total from transactions where date_time between ? and ? group by month_name"
    Transaction.find_by_sql([sql, 1.year.ago, Time.now]).map do |t|
      [I18n.t('date.month_names')[t.month_name], t.total]
    end
  end
end
