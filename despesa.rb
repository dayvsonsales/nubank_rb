# frozen_string_literal: true

require 'date'

class Despesa
  def initialize(dados)
    @dados = parse(dados)
  end

  def to_ary
    @dados.values_at(:data, :descricao, :valor, :categoria)
  end

  private

  def parse(dados)
    { data: Date.parse(dados[:post_date]).strftime('%d/%m/%y'),
      descricao: dados[:title],
      valor: (dados[:amount] / 100.0),
      categoria: dados[:category] }
  end
end
