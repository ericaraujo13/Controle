module BalanceHelper
  def next_12_months
    sql = %{select date_part('month', date_time) as month_name, count(*) as total from transactions
    inner join products on products.id = transactions.product_id where date_time
    between ? and ? and products.user_id = ? group by month_name}
    Transaction.find_by_sql([sql, 1.year.ago, Time.now, current_user.id]).map do |t|
      [I18n.t('date.month_names')[t.month_name], t.total]
    end
  end
end
