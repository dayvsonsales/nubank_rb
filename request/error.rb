# frozen_string_literal: true

module Request
  # Generic request error
  class Error < StandardError
    def initialize(msg)
      super(msg)
    end
  end
end
