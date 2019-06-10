# frozen_string_literal: true

require_relative '../client'
require 'json'

module Request
  module Auth
    # Class that make the request to obtain an access_token from QR Code UUID
    class QrCode
      LOGIN_TYPE = 'login-webapp'

      class << self
        def call(login_url, uuid, access_token)
          Request::Client.call(login_url, :post, body: body(uuid), headers: headers(access_token))
        end

        private

        def body(uuid)
          { 'qr_code_id' => uuid,
            'type' => LOGIN_TYPE }.to_json
        end

        def headers(access_token)
          Request::Client::HEADERS.merge('Authorization' => "Bearer #{access_token}")
        end
      end
    end
  end
end
