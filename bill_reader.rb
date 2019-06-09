# frozen_string_literal: true

require 'typhoeus'
require 'oj'
require_relative './bill'

class BillReader
  BILL_DETAILS_URL = 'https://prod-s0-webapp-proxy.nubank.com.br/api/proxy/AJxL5LAziMKqnUwY9alHjwU8Rn2zqgJlVA.aHR0cHM6Ly9wcm9kLXMwLWJpbGxpbmcubnViYW5rLmNvbS5ici9hcGkvYmlsbHMvNWNmMGI2NjItZmVhNi00ODgwLTkzYmItM2Q2ZTkyNGM1Nzhj'
  HEADERS = {
    'Content-Type' => 'application/json',
    'X-Correlation-Id' => 'WEB-APP.jO4x1',
    'User-Agent' => 'nubank_rb',
    'Authorization' => 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjIwMTUtMTItMDRUMTc6MzY6MjIuNjY0LXU5ZC1ldWN1Ri1zQUFBRlJiaER3aUEifQ.eyJhdWQiOiJvdGhlci5jb250YSIsInN1YiI6IjU5MDBkNjcxLWI1M2MtNGE1Ni1hZGQzLTE5MjA0M2JhY2ZlYSIsImlzcyI6Imh0dHBzOlwvXC93d3cubnViYW5rLmNvbS5iciIsImV4cCI6MTU2MDY0NDY1Niwic2NvcGUiOiJhdXRoXC91c2VyIHVzZXIiLCJqdGkiOiI2ZUFQUDFaWlAzWUFBQUZyT1o4YTRnIiwibXRscyI6ZmFsc2UsImFjbCI6bnVsbCwidmVyc2lvbiI6IjIiLCJpYXQiOjE1NjAwMzk4NTZ9.OgvcmwmB1IvLCP2HEbyjToXCYob2zc594cAyA-gOvxSjyLpm5Rf7rnSkXx-fb4tTyjeGPgICJ1t2COHQ1dG9pXieqoTeLbAJ5rPl8lgaw6Z_dcd7QX-ZGg_oXr9Sma6b_dq8b6fpE19A3J8OEMlUQR9sUDJVvdxtPcVG-ykMWuTF8qLT2SEMxLkZBVhtKgIUXcy9HXF60U8M-irhMMAMECJKWMfgDXmxIW7cRZu7UxuLPuGt2J49QISO2BCSb9pUJOrQmklSfe2633zOrtSdGRSnxLTsxahGhPbxM4fdgUGkj9KD2OkcCmQECkoA67yHUABgMd2mslSEoZti4Osp8A'
  }

  def self.call(bill_url = nil)
    request = Typhoeus.get((bill_url || BILL_DETAILS_URL), headers: HEADERS)
    response = Oj.load(request.response_body, symbol_keys: true)
    Bill.new(response[:bill])
  end
end
