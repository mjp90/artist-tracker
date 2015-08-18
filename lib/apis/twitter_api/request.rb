module Apis
  module TwitterApi
    class Request
      attr_reader :error, :formatted_response

      def initialize(client:, request_name:, response_formatter:, arg: nil)
        @client             = client
        @request_name       = request_name
        @response_formatter = response_formatter
        @arg                = arg
        @error              = nil
        @formatted_response = nil
      end

      def success?
        @error.nil?
      end

      def send(options)
        response = client.send(request_name, arg, options)
      rescue Twitter::Error::TooManyRequests => e
        @error = Twitter::RequestError.new(e)
      else
        @formatted_response = response_formatter.new(response: response).serialize
      end

      def send
        response = client.send(request_name, arg)
      rescue Twitter::Error::TooManyRequests => e
        @error = Twitter::RequestError.new(e)
      else
        @formatted_response = response_formatter.new(response: response).serialize
      end

      private
      attr_reader :client, :request_name, :response_formatter, :arg
    end
  end
end
