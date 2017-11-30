module Twit
  # @todo Add more attributes
  # @see https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/get-statuses-show-id
  class Tweet
    # @return [Time] when the tweet was created
    attr_reader :created_at
    alias_method :date, :created_at

    # @return [Integer] the unique id
    attr_reader :id

    # @return [String] Tweet text content
    attr_reader :text
    alias_method :content, :text

    # @return [Tweet]
    def initialize(data)
      @created_at = Time.parse(data[:created_at])
      @id         = data[:id]
      @text       = data[:full_text]
    end
  end
end
