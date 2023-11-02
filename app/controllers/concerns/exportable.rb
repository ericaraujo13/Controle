require 'csv'

module Exportable
  extend ActiveSupport::Concern

  def export_csv
    headers = ["Descrição", "Tipo", "Valor", "Data"]

    csv = CSV.generate(write_headers: true, headers: headers) do |row|
      Finance.all.each do |finance|
        row << [
          finance.description,
          finance.transaction_type,
          if finance.transaction_type === "saida"
            "- #{finance.amount}"
          else
            "+ #{finance.amount}"
          end,  
          finance.created_at.strftime("%d/%m/%Y"),
        ]
      end
    end

    send_data csv, type: 'text/csv; charset=utf-8; header=present',
      dispositon: "attachment; filename=Extrato#{Date.current}"
  end
end