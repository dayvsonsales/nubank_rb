# frozen_string_literal: true

require 'erb'
require 'launchy'

module QrCode
  # Render a QR Code page from its data
  class Render
    FILENAME = 'qr_code.html'

    def self.call(qr_code)
      @qr_code = qr_code
      result = ERB.new(template).result(binding)

      File.open(FILENAME, 'w') { |file| file.write(result) }
      Launchy.open("file:///#{File.expand_path(__dir__)}/#{FILENAME}")
    end

    private

    def template
      File.open('template.erb', 'rb', &:read)
    end
  end
end
