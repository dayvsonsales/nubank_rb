# frozen_string_literal: true

require 'typhoeus'
require 'oj'
require_relative './error'

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
      body = request.response_body
      code = request.response_code
      raise Request::Error, "Request failed ==> Code: #{code}, Body: #{body}" if code >= 400

      Oj.load(body, symbol_keys: true)
    end
  end
end
