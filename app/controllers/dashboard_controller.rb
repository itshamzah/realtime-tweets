require 'factories/twitter'

class DashboardController < ApplicationController
	include TwitterFactory

	before_action :authenticate_user!
  before_action :set_user, only: [:index, :wall]

	def index
    # REST client to make API calls for logged in user
    twitter_rest_client = TwitterFactory.new_rest_client(@user[:token], @user[:secret])

    @tweets = twitter_rest_client.user_timeline(tweet_params.symbolize_keys).take(20)
    @tweets.map! { |tweet| TwitterFactory::Tweet.new(tweet) }

    set_page
    respond_to do |format|
      format.html
      format.json { render json: @tweets }
    end
	end

	def wall
		# REST client to make API calls for logged in user
    twitter_rest_client = TwitterFactory.new_rest_client( @user[:token], @user[:secret] )

    @tweets = twitter_rest_client.home_timeline(tweet_params.symbolize_keys)
    @tweets.map! { |tweet| TwitterFactory::Tweet.new(tweet) }

    set_page
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

  def set_page
    @page_number = params[:page].nil? ? 1 : params[:page] .to_i
  end

  def default_params
    { page: 1, count: 20 }
  end

  def check_valid
    params.merge({ count: 20 })
    return params if (params[:page] && params[:page].to_i.between?(1, 4))

    params.merge(default_params)
  end

  def tweet_params
    check_valid.permit(:page, :count).to_h
  end
end