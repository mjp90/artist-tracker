# e.rate_limit returns a RateLimit Object
# Mail Message { code: e.code, message: e.message, max_limit: e.rate_limit.limit, remaining: e.rate_limit.remaining, reset_at: e.rate_limit.reset_at (DateTime), reset_in: e.rate_limit.reset_in (Seconds until can reset) }
module Twitter
  class RequestError
    def initialize(error_response:)
      @error_response = error_response
    end

    def code
      error_response.code
    end

    def message
      error_response.message
    end

    def limit
      error_response.rate_limit.limit
    end

    def remaining
      error_response.rate_limit.remaining
    end

    def reset_at
      error_response.rate_limit.reset_at
    end

    def reset_in
      error_response.rate_limit.reset_in
    end

    private
    attr_reader :error_response
  end
end
