# frozen_string_literal: true

require 'rest-client'
require 'base64'
require 'json'

module Twit
  # API class methods
  module API
    APIBASE = 'https://api.twitter.com'

    module_function

    # Retrieve a single tweet by ID
    # @param id [String, Integer] status id
    def status(token, id)
      response =
        request(
          :get,
          "#{APIBASE}/1.1/statuses/show/#{id}.json",
          Authorization: "Bearer #{token}",
          params: { tweet_mode: 'extended' }
        )
      parse_json(response.body)
    end

    # Retrieve an OAuth2 bearer token used
    #   for application-only endpoints
    # @param key [String] consumer key
    # @param secret [String] consumer secret
    # @return [String] OAuth2 bearer token
    def access_token(key, secret)
      basic = [key, secret].join(':')
      auth = Base64.strict_encode64(basic)
      response =
        request(
          :post,
          "#{APIBASE}/oauth2/token",
          { grant_type: 'client_credentials' },
          authorization: "Basic #{auth}"
        )
      json = parse_json(response.body)
      json[:access_token]
    end

    # Performs a RestClient request
    # @param method [Symbol] HTTP request method
    # @param attributes [Array] Attributes for the request
    def request(method, *attributes)
      RestClient.send(method, *attributes)
    rescue RestClient::Forbidden
      raise 'invalid consumer or secret'
    end

    def parse_json(data)
      JSON.parse(data, symbolize_names: true)
    end
  end
end
