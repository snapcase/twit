require 'twit/api'

module Twit
  class Client
    def initialize(key, secret)
      @token = API.access_token(key, secret)
    end
  end
end
