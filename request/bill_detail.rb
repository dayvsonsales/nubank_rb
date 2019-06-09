# frozen_string_literal: true

require_relative './client'

module Request
  # Request to get the details of a bill
  class BillDetail
    class << self
      def call(bill, access_token)
        bill_url = bill.dig(:_links, :self, :href)

        Request::Client.call(bill_url, :get, headers: headers(access_token))
      end

      private

      def headers(access_token)
        Request::Client::HEADERS.merge('Authorization' => "Bearer #{access_token}")
      end
    end
  end
end
