# frozen_string_literal: true

require 'erb'
require 'launchy'

module QrCode
  # Render a QR Code page from its data
  class Render
    FILENAME = 'qr_code.html'

    class << self
      def call(qr_code, uuid)
        @qr_code = qr_code
        @uuid = uuid
        result = ERB.new(template).result(binding)

        filename = "#{current_dir}/#{FILENAME}"
        File.open(filename, 'w') { |file| file.write(result) }
        Launchy.open("file:///#{filename}")
      end

      private

      def template
        File.open("#{current_dir}/template.erb", 'rb', &:read)
      end

      def current_dir
        @current_dir ||= File.expand_path(__dir__)
      end
    end
  end
end
