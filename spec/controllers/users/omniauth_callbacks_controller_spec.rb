# omniauth_callbacks_controller_spec.rb
require 'spec_helper'

describe Users::OmniauthCallbacksController  do
  let(:current_user) { FactoryBot.create(:user) }
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
        provider: :twitter,
        uid: rand(5**10),
        credentials: { token: ENV['CLIENT_ID'], secret: ENV['CLIENT_SECRET'] }
    )
    allow(@controller).to receive(:env) { { 'omniauth.auth' => OmniAuth.config.mock_auth[:twitter] } }
    allow(User).to receive(:from_omniauth) { current_user }
  end
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  end


  describe "#twitter" do
    context 'new user' do
      it 'redirect to sign_in_and_redirect' do
        expect {
          subject.twitter
        }.to change {User.count}.by(1)
      end
    end
  end
end

