require 'twit/api'
require 'twit/objects'

module Twit
  class Client
    def initialize(key, secret)
      @token = API.access_token(key, secret)
    end

    # Retrieve a single tweet by ID
    # @param id [String, Integer] status id
    # @return [Tweet] a single Tweet
    def status(id)
      data = API.status(@token, id)
      Tweet.new(data)
    end

    alias_method :tweet, :status
  end
end
