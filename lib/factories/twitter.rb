require 'twitter'

# Module to handle twitter Api flows
module TwitterFactory

  # Setup config from twitter initializer
  def self.configure(config = {})
    @config = config
  end

  # Tweet objects parsing a kind of View Model to be used in views
  class Tweet
    attr_accessor :text, :user_tw_id, :user_nickname, :user_image, :created_at

    def initialize(object)
      tweet_object({
        text: object.text,
        user_tw_id: object.user.id.to_s,
        user_nickname: object.user.screen_name,
        user_image: object.user.profile_image_url.to_s,
        created_at: object.created_at.to_s
      })
    end

    def tweet_object(tweet)
      tweet.each do |name, value|
        send("#{name}=", value)
      end
      tweet
    end
  end

  #  Twitter api REST cleint for making calls
  def self.new_rest_client(token = '', secret = '')
    config = {
      consumer_key: @config[:consumer_key],
      consumer_secret: @config[:consumer_secret],
      access_token: token,
      access_token_secret: secret
    }
    Twitter::REST::Client.new(config)
  end

end