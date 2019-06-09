# frozen_string_literal: true

require 'rqrcode'
require 'erb'
require 'launchy'

module QrCode
  # Create a QR Code from UUID
  class Creator
    QRCODE_FILENAME = 'qr_code.html'

    def self.create(uuid)
      @qr = RQRCode::QRCode.new(uuid)

      template = File.open('template.erb', 'rb', &:read)
      result = ERB.new(template).result(binding)

      File.open(QRCODE_FILENAME, 'w') { |file| file.write(result) }
      Launchy.open("file:///home/danilo/oss/nubank_rb/#{QRCODE_FILENAME}")
    end
  end
end
