# frozen_string_literal: true

require 'rqrcode'
require 'securerandom'

class QrCode
  def self.create(uuid)
    RQRCode::QRCode.new(uuid)
  end

  def self.generate_uuid
    SecureRandom.uuid
  end
end
