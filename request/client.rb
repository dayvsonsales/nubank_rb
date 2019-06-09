# frozen_string_literal: true

require 'typhoeus'
require 'oj'

module Request
  # Basic request client
  class Client
    HEADERS = { 'Content-Type' => 'application/json',
                'X-Correlation-Id' => 'WEB-APP.pewW9',
                'User-Agent' => 'nubank_rb - https://github.com/danilobarion1986/nubank_rb',
                'Origin' => 'https://conta.nubank.com.br',
                'Referer' => 'https://conta.nubank.com.br/' }.freeze

    def self.call(url, method = :get, options = {})
      request = Typhoeus.send(method, url, options)
      Oj.load(request.response_body, symbol_keys: true)
    end
  end
end
