# frozen_string_literal: true

require 'typhoeus'
require 'oj'

module Request
  # Basic request client
  class Client
    def self.call(url, method = :get, options = {})
      request = Typhoeus.send(method, url, options)
      Oj.load(request.response_body, symbol_keys: true)
    end
  end
end
