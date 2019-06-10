# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  add_group 'Models', 'model'
  add_group 'QR Code', 'qr_code'
  add_group 'Requests', 'request'
  add_group 'XLSX', 'xlsx'
end

require_relative '../qr_code/creator'
require_relative '../qr_code/render'
require_relative '../xlsx/creator'
require_relative '../request/discovery_url'
require_relative '../request/discovery_app_url'
require_relative '../request/bills'
require_relative '../request/bill_detail'
require_relative '../request/auth/qr_code'
require_relative '../request/auth/password'
