# frozen_string_literal: true

require 'spreadsheet_architect'
require 'date'
require_relative './bill_reader'
require_relative './despesa'

class Converter
  attr_reader :bill

  def initialize
    @bill = BillReader.call # Deixar URL da fatura dinâmica
  end

  def to_xlsx
    headers = ['Data', 'Descrição', 'Valor', 'Categoria']
    valores = @bill.items.map do |despesa|
      Despesa.new(despesa).to_ary
    end
    file_data = ::SpreadsheetArchitect.to_xlsx(headers: headers, data: valores)
    agora = Time.now.strftime('%d-%m-%y-%H-%M')
    File.open("fatura_nubank_#{agora}.xlsx", 'w+b') do |f|
      f.write(file_data)
    end
  end
end

Converter.new.to_xlsx
