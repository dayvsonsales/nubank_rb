# frozen_string_literal: true

require 'date'

module Model
  # Parse expense data
  class ExpenseParser
    def self.call(data)
      { data: Date.parse(data[:post_date]).strftime('%d/%m/%y'),
        descricao: data[:title],
        valor: (data[:amount] / 100.0),
        categoria: data[:category] }
    rescue
      {}
    end
  end
end
