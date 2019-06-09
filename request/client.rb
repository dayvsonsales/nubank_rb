# frozen_string_literal: true

require 'typhoeus'
require 'oj'

module Request
  # Basic request client
  class Client
    CONTENT_TYPE = 'application/json'
    X_CORRELATION_ID = 'WEB-APP.pewW9'
    USER_AGENT = 'nubank_rb - https://github.com/danilobarion1986/nubank_rb'
    ORIGIN = 'https://conta.nubank.com.br'
    REFERER = 'https://conta.nubank.com.br/'
    HEADERS = { 'Content-Type' => CONTENT_TYPE,
                'X-Correlation-Id' => X_CORRELATION_ID,
                'User-Agent' => USER_AGENT,
                'Origin' => ORIGIN,
                'Referer' => REFERER }.freeze

    def self.call(url, method = :get, options = {})
      request = Typhoeus.send(method, url, options)
      Oj.load(request.response_body, symbol_keys: true)
    end
  end
end
