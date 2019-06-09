# frozen_string_literal: true

require 'spreadsheet_architect'
require 'date'
require_relative '../model/expense'

module Xlsx
  # Create a .xlsx file using bill data
  class Creator
    HEADERS = %w[Data Descrição Valor Categoria].freeze

    def self.call(bill)
      values = bill.items.map { |expense| Model::Expense.new(expense).to_ary }
      xlsx_data = SpreadsheetArchitect.to_xlsx(headers: HEADERS, data: values)
      now = Time.now.strftime('%d_%m_%y__%H_%M')

      File.open("nubank_bill_#{now}.xlsx", 'w+b') { |f| f.write(xlsx_data) }
    end
  end
end
