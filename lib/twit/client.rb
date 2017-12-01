# frozen_string_literal: true

require 'twit/api'
require 'twit/objects'

module Twit
  # Client
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

    alias tweet status
  end
end
