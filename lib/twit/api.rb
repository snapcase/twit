require 'rest-client'
require 'base64'
require 'json'

module Twit
  module API
    APIBASE = 'https://api.twitter.com'.freeze

    module_function

    # retrieve oauth2 bearer token
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
          { authorization: "Basic #{auth}" }
        )
      json = JSON.parse(response.body, symbolize_names: true)
      json[:access_token]
    end

    def request(method, *attributes)
      RestClient.send(method, *attributes)
    rescue RestClient::Forbidden
      raise 'invalid consumer or secret'
    end
  end
end
