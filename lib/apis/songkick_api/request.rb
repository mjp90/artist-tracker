module Apis
  module SongkickApi
    class Request
      attr_reader :error, :formatted_response

      def initialize(url:, response_formatter:)
        @url = url
        @response_formatter = response_formatter
      end

      def send
        response = JSON.parse(RestClient.get(url, nil))["resultsPage"]
      rescue Exception => e
        @error = Songkick::RequestError.new(e)
      else
        @formatted_response = response_formatter.new(response: response).serialize
      end

      private
      attr_reader :url, :response_formatter
    end
  end
end
