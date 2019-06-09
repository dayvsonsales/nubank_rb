# frozen_string_literal: true

require_relative '../client'

module Request
  module Auth
    # Class that make the request to obtain an access_token from login/password
    class Password
      GRANT_TYPE = 'password'
      CLIENT_ID = 'other.conta'
      CLIENT_SECRET = 'yQPeLzoHuJzlMMSAjC-LgNUJdUecx8XO'
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

      class << self
        def self.call(login_url, login, password)
          Request::Client.call(login_url, :post, body: body(login, password), headers: HEADERS)
        end

        private

        def body(login, password)
          { 'grant_type' => GRANT_TYPE,
            'login' => login,
            'password' => password,
            'client_id' => CLIENT_ID,
            'client_secret' => CLIENT_SECRET }
        end
      end
    end
  end
end
