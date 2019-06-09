# frozen_string_literal: true

require 'erb'

template = File.open('qr_code_template.erb', 'rb', &:read)
result = ERB.new(template).result

File.open('qr_code_result.html', 'w') { |file| file.write(result) }
