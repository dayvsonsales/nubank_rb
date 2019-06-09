# frozen_string_literal: true

class Bill
  attr_reader :items, :summary, :links

  def initialize(dados)
    @items = dados[:line_items]
    @summary = dados[:summary]
    @links = dados[:_links]
  end
end
