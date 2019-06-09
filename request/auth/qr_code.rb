# frozen_string_literal: true

require_relative '../client'

module Request
  module Auth
    # Class that make the request to obtain an access_token from QR Code UUID
    class QrCode
      LOGIN_TYPE = 'login-webapp'
      CONTENT_TYPE = 'application/json'
      X_CORRELATION_ID = 'WEB-APP.pewW9'
      USER_AGENT = 'nubank_rb - https://github.com/danilobarion1986/nubank_rb'
      ORIGIN = 'https://conta.nubank.com.br'
      REFERER = 'https://conta.nubank.com.br/'

      class << self
        def call(login_url, uuid, access_token)
          Request::Client.call(login_url, :post, body: body(uuid), headers: headers(access_token))
        end

        private

        def body(uuid)
          { 'qr_code_id' => uuid,
            'type' => LOGIN_TYPE }
        end

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
  end
end
