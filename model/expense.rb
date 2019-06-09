# frozen_string_literal: true

require 'date'

module Model
  # Get the necessary information from a bill's expense
  class Expense
    def initialize(data)
      @data = parse(data)
    end

    def to_ary
      @data.values_at(:data, :descricao, :valor, :categoria)
    end

    private

    def parse(data)
      { data: Date.parse(data[:post_date]).strftime('%d/%m/%y'),
        descricao: data[:title],
        valor: (data[:amount] / 100.0),
        categoria: data[:category] }
    end
  end
end
