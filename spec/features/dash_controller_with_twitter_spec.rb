require 'rails_helper'

RSpec.describe DashboardController, :type => :controller do
  before(:each) do
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  describe "GET index" do
    before do
      stub_billing_request(:get, "https://api.twitter.com/1.1/statuses/user_timeline.json?count=200&page=1")
          .to_return(status: 200, body: "", headers: {})
    end

    context 'when user is logged' do
      it "shows all activities for signed in user" do
        get :index
        expect(response).to be_success
      end
    end

    # context 'when user is anonymous' do
    #   it "redirects user to root path" do
    #     get :well
    #     expect(response).to redirect_to root_path
    #   end
    # end
  end

  def stub_billing_request(method, path)
    WebMock.stub_request(method, path).with( headers: {'Authorization' => "OAuth oauth_consumer_key='Zwnd9EFbLcTIOKQ9ABhDYiFoD', oauth_nonce='231e1a7d77738017ef9e43ae1ea4be02', oauth_signature='qcYrODLtTWbrGea%2BE6nYqz3kLEA%3D', oauth_signature_method='HMAC-SHA1', oauth_timestamp= #{Time.now.to_i}, oauth_token='mock_token', oauth_version='1.0'", 'Connection' => 'close', 'Host' => 'api.twitter.com', 'User-Agent' => 'TwitterRubyGem/7.0.0'})
  end
end