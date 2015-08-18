module Apis
  module TwitterApi
    class Request
      attr_reader :error, :formatted_response

      def initialize(client:, request_name:, response_formatter:, arg: nil, options: nil)
        @client             = client
        @request_name       = request_name
        @response_formatter = response_formatter
        @arg                = arg
        @options            = options
        @error              = nil
        @formatted_response = nil
      end

      def success?
        @error.nil?
      end

      def send
        response = send_request
        binding.pry
      rescue Twitter::Error::TooManyRequests => e
        @error = Twitter::RequestError.new(e)
      else
        @formatted_response = response_formatter.new(response: response).serialize
      end

      private
      attr_reader :client, :request_name, :response_formatter, :arg, :options

      def send_request
        if options.present?
          client.send(request_name, arg, options)
        else
          client.send(request_name, arg)
        end
      end
    end
  end
end
