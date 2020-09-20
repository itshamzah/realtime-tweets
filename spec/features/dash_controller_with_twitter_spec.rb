require 'rails_helper'

RSpec.describe DashboardController, :type => :controller do

  describe "GET index" do
    before(:each) do
      @user = FactoryBot.create(:user)
      sign_in @user
    end

    before do
      stub_billing_request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?count=200&page=1")
          .to_return(status: 200, body: "", headers: {})
    end


    # let!(:stubbed_request) do
    #   stub_request(:get, 'https://api.twitter.com/1.1/statuses/user_timeline.json?count=200&page=1')
    #       .with(headers: {
    #           'Authorization'=>'OAuth oauth_consumer_key="Zwnd9EFbLcTIOKQ9ABhDYiFoD", oauth_nonce="231e1a7d77738017ef9e43ae1ea4be02", oauth_signature="qcYrODLtTWbrGea%2BE6nYqz3kLEA%3D", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1600572893", oauth_token="mock_token", oauth_version="1.0"',
    #           'Connection'=>'close',
    #           'Host'=>'api.twitter.com',
    #           'User-Agent'=>'TwitterRubyGem/7.0.0'
    #       })
    # .to_return(status: 200, body: JSON.dump( [{
    #                         created_at: "2020-09-20",
    #                         retweet_count: 0,
    #                         screen_name: "test",
    #                         text: "hello world",
    #                         user_image: "http://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png",
    #                         user_nickname: "imransarfaraz15",
    #                         user_tw_id: "1307494312863817735"}]))
    end

    context 'when user is logged' do
      it "shows all activities for signed in user" do
        get :index
        # expect(response).to be_success
      end
    end

    # context 'when user is anonymous' do
    #   it "redirects user to root path" do
    #     get :well
    # expect(response).to redirect_to root_path
    # end
    # end
  end

  def stub_billing_request(method, path)
    WebMock.stub_request(method, path).with(headers: {'Authorization' => 'OAuth oauth_consumer_key="Zwnd9EFbLcTIOKQ9ABhDYiFoD", oauth_nonce="231e1a7d77738017ef9e43ae1ea4be02", oauth_signature="qcYrODLtTWbrGea%2BE6nYqz3kLEA%3D", oauth_signature_method="HMAC-SHA1", oauth_timestamp="1600572893", oauth_token="mock_token", oauth_version="1.0"', 'Connection' => 'close', 'Host' => 'api.twitter.com', 'User-Agent' => 'TwitterRubyGem/7.0.0'})
  end

end