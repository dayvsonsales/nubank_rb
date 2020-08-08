# frozen_string_literal: true

require 'spreadsheet_architect'
require 'spreadsheet'
require 'date'

require_relative '../model/expense'

module Xlsx
  # Create a .xlsx file using bill data
  class Creator
    HEADERS = %w[Data Descrição Valor Categoria].freeze

    class << self
      def call(bill)
        xlsx_data = SpreadsheetArchitect.to_xlsx(headers: HEADERS, data: values_from(bill))
        now = Time.now.strftime('%d_%m_%y__%H_%M')

        File.open("nubank_bill_#{now}.xlsx", 'w+b') { |file| file.write(xlsx_data) }
      end

      def call_years(years) 
        years.each do |key, value|
          book = Spreadsheet.open "#{File.expand_path('../../', __FILE__)}/template.xls"
          
          sheet = book.worksheet 0
          sheet.each_with_index do |row, index|
            if years[key].has_key?(index) then
              row[1] = years[key][index].to_f
            else
              row[1] = 0.0
            end
          end

          book.write "#{File.expand_path('../../', __FILE__)}/output/#{key}.xls"
        end
      end

      private

      def values_from(bill)
        bill[:line_items].map { |expense| Model::Expense.new(expense).to_ary }
      end
    end
  end
end
