# frozen_string_literal: true

require 'securerandom'
require_relative './qr_code/creator'
require_relative './xlsx/creator'
require_relative './request/discovery_url'
require_relative './request/discovery_app_url'
require_relative './request/bills'
require_relative './request/bill_detail'
require_relative './request/auth/qr_code'
require_relative './request/auth/password'

# 0) Get login and password from environment variables
login = ENV['NUBANK_LOGIN']
password = ENV['NUBANK_PASSWORD']
raise ArgumentError, 'Login or password not found in environment variables!' unless login && password

# 1) Obtain valid URL's via discovery
urls = Request::DiscoveryUrl.call
app_urls = Request::DiscoveryAppUrl.call

# 2) Generate UUID and QR Code from it
uuid = SecureRandom.uuid
QrCode::Creator.create(uuid)
sleep 45

# 3) Call login URL, to obtain an access_token
login_response = Request::Auth::Password.call(urls[:login], login, password)

# 4) Call QR Code login URL to obtain a new access_token
features_urls = Request::Auth::QrCode.call(app_urls[:lift], uuid, login_response[:access_token])

# 5) Get bills summary
bills_url = self.bills_url = features_urls.dig(:_links, :bills_summary, :href)
bills = Request::Bills.call(bills_url).fetch(:bills)

# 6) Select one or more bills to get detailed information
puts 'Choose bill to get data from:'
bills.each_with_index do |bill, index|
  link = bill.dig(:_links, :self, :href)
  puts "  #{index}) #{link}"
end
chosen_bill_index = gets

# 7) Get details of the chosen bill
bill = Request::BillDetail.call(bills[chosen_bill_index])

# 8) Save bill details to a .xlsx file
Xlsx::Creator.call(bill)
