# frozen_string_literal: true

require_relative './client'

module Request
  # Request to get all available bills
  class Bills
    class << self
      def call(bills_url, access_token)
        Request::Client.call(bills_url, :get, headers: headers(access_token))
      end

      private

      def headers(access_token)
        Request::Client::HEADERS.merge('Authorization' => "Bearer #{access_token}")
      end
    end
  end
end
