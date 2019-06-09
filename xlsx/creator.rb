# frozen_string_literal: true

require 'spreadsheet_architect'
require 'date'
require_relative '../expense'

class Xlsx::Creator
  def self.call(bill)
    headers = %w[Data Descrição Valor Categoria]
    values = bill.items.map do |expense|
      Expense.new(expense).to_ary
    end
    xlsx_data = SpreadsheetArchitect.to_xlsx(headers: headers, data: values)
    File.open("nubank_bill_#{Time.now.strftime('%d_%m_%y__%H_%M')}.xlsx", 'w+b') do |f|
      f.write(xlsx_data)
    end
  end
end
