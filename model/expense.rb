# frozen_string_literal: true

require_relative './expense_parser'

module Model
  # Get the necessary information from a bill's expense
  class Expense
    def initialize(data)
      @data = ExpenseParser.call(data)
    end

    def to_ary
      @data.values_at(:data, :descricao, :valor, :categoria)
    end
  end
end
