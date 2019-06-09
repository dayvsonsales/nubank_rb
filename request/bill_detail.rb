# frozen_string_literal: true

require_relative './Client'

class Request::BillDetail
  CONTENT_TYPE = 'application/json'
  X_CORRELATION_ID = 'WEB-APP.pewW9'
  USER_AGENT = 'nubank_rb - https://github.com/danilobarion1986/nubank_rb'
  ORIGIN = 'https://conta.nubank.com.br'
  REFERER = 'https://conta.nubank.com.br/'

  class << self
    def call(bill, access_token)
      bill_url = bill.dig(:_links, :self, :href)

      Request::Client.call(bill_url, :get, headers: headers(access_token))
    end

    private

    def headers(access_token)
      { 'Content-Type' => CONTENT_TYPE,
        'X-Correlation-Id' => X_CORRELATION_ID,
        'User-Agent' => USER_AGENT,
        'Origin' => ORIGIN,
        'Referer' => REFERER,
        'Authorization' => "Bearer #{access_token}" }
    end
  end
end
