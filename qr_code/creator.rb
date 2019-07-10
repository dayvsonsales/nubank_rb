# frozen_string_literal: true

require 'rqrcode'

module QrCode
  # Create a QR Code from UUID
  class Creator
    def self.call(uuid)
      RQRCode::QRCode.new(uuid)
    end
  end
end
