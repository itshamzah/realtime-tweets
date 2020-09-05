require 'factories/twitter'

class DashboardController < ApplicationController
	include TwitterFactory

	before_action :authenticate_user!
  before_action :set_user, only: [:index, :wall]

	def index
    # REST client to make API calls for logged in user
    twitter_rest_client = TwitterFactory.new_rest_client( @user[:token], @user[:secret] )

    @tweets = twitter_rest_client.user_timeline(page: 1, count: 20).take(20)
    @tweets.map! { |tweet| TwitterFactory::Tweet.new(tweet) }

    respond_to do |format|
      format.html
      format.json { render json: @tweets }
    end
	end

	def wall
		# REST client to make API calls for logged in user
    twitter_rest_client = TwitterFactory.new_rest_client( @user[:token], @user[:secret] )

    @tweets = twitter_rest_client.home_timeline(page: 1, count: 20).take(20)
    @tweets.map! { |tweet| TwitterFactory::Tweet.new(tweet) }

    respond_to do |format|
      format.html
      format.json { render json: @tweets }
    end
	end

  private

  def set_user
    # Logged in user setup
    @user = current_user
    redirect_to root_path unless @user
  end
end