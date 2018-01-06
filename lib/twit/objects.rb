# frozen_string_literal: true
require 'cgi'

module Twit
  # @todo Add more attributes
  # @see https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/get-statuses-show-id
  class Tweet
    # @return [Time] when the tweet was created
    attr_reader :created_at
    alias date created_at

    # @return [Integer] Unique tweet ID
    attr_reader :id

    # @return [String] Tweet text content
    attr_reader :text
    alias content text

    # @return [User] User that posted status
    attr_reader :user

    # @return [Tweet]
    def initialize(data)
      @created_at = Time.parse(data[:created_at])
      @id = data[:id]
      @text = CGI.unescapeHTML(data[:full_text])
      @user = User.new(data[:user])
    end
  end

  # @todo Add more attributes
  # @see https://developer.twitter.com/en/docs/tweets/data-dictionary/overview/user-object
  class User
    # @return [Integer] The integer representation of the unique identifier for this User
    attr_reader :id

    # @return [String] The name of the user, as they've defined it
    attr_reader :name

    # @return [String] The screen name, handle, or alias that this user identifies themselves with
    attr_reader :screen_name
    alias alias screen_name
    alias handle screen_name

    # @return [String] The user-defined location for this account's profile
    attr_reader :location

    # @return [String] The user-defined describing their account
    attr_reader :description

    # @return [String, nil] A URL provided by the user in association with their profile
    attr_reader :url

    def initialize(data)
      @id = data[:id]
      @name = data[:name]
      @screen_name = data[:screen_name]
      @location = data[:location]
      @description = data[:description]
      @url = data[:url]
    end
  end
end
