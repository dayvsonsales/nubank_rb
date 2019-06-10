# frozen_string_literal: true

require 'securerandom'
require_relative './qr_code/creator'
require_relative './qr_code/render'
require_relative './xlsx/creator'
require_relative './request/discovery_url'
require_relative './request/discovery_app_url'
require_relative './request/bills'
require_relative './request/bill_detail'
require_relative './request/auth/qr_code'
require_relative './request/auth/password'

# # 0) Get login and password from environment variables
login = ENV['NUBANK_LOGIN']
password = ENV['NUBANK_PASSWORD']
raise ArgumentError, 'Login or password not found in environment variables!' unless login && password

# 1) Obtain valid URL's via discovery
puts '====> Discovering Nubank API endpoints...'
urls = Request::DiscoveryUrl.call
app_urls = Request::DiscoveryAppUrl.call

# 2) Generate UUID and QR Code from it
puts '====> Generating QR Code...'
uuid = SecureRandom.uuid
qr_code = QrCode::Creator.create(uuid)
QrCode::Render.call(qr_code, uuid)
puts "========> You have 45 seconds to scan it!"
45.downto(0) { |seconds| puts "00:00:#{seconds}"; sleep 1 }

# 3) Call login URL, to obtain an access_token
puts '====> Authenticating login and password...'
login_response = Request::Auth::Password.call(urls[:login], login, password)

# 4) Call QR Code login URL to obtain a new access_token
puts '====> Authenticating QR Code...'
login_qr_code_response = Request::Auth::QrCode.call(app_urls[:lift], uuid, login_response[:access_token])
qr_code_access_token = login_qr_code_response[:access_token]
features_urls = login_qr_code_response[:_links]

# 5) Get bills summary
puts '====> Retrieving Bills Summary...'
bills_url = features_urls.dig(:bills_summary, :href)
bills = Request::Bills.call(bills_url, qr_code_access_token).fetch(:bills)

# 6) Select one or more bills to get detailed information
puts
puts 'Choose bill to get data from:'
bills.reject! { |bill| bill[:state] == 'future' }.each_with_index do |bill, index|
  state = bill[:state]
  due_date = bill.dig(:summary, :due_date)
  expenses = bill.dig(:summary, :expenses)
  puts "#{index}) [#{state}] R$ #{expenses}, due date: #{due_date}"
end
chosen_bill_index = gets

# 7) Get details of the chosen bill
bill = Request::BillDetail.call(bills[chosen_bill_index.to_i], qr_code_access_token).fetch(:bill)

# 8) Save bill details to a .xlsx file
Xlsx::Creator.call(bill)
