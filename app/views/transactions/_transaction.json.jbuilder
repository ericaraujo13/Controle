json.extract! transaction, :id, :product_id, :quantity, :date_time, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
