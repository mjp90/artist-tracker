module Songkick
  class RequestError
    def initialize(error_response:)
      @error_response = error_response
    end

    def code
      error_response.code
    end

    private
    attr_reader :error_response
  end
end
