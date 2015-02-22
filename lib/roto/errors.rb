module Roto
  class Error < StandardError; end

  module Errors
    class InvalidHMACError < Roto::Error
    end
  end
end
