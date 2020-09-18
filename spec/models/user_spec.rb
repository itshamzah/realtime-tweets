require 'rails_helper'

auth_hash = OmniAuth::AuthHash.new({
                                       :provider => 'twitter',
                                       :uid => '1234',
                                       :info => {
                                         :email => "user@example.com",
                                         :nick_name => "alexa"
                                       },
                                       extra: {
                                         raw_info: {
                                           screen_name: 'mock_screen_name',
                                           followers_count: 'mock_followers_count',
                                           friends_count: 'mock_friends_count',
                                           statuses_count: 'mock_statuses_count',
                                           }
                                       },
                                       credentials: {token: 'mock_token', secret: 'mock_secret'}
                                   })

describe User, "#from_omniauth" do
  it "retrieves an existing user" do
    user = User.new(
      :provider => "twitter",
      :uid => 1234,
      :email => "user@example.com",
      :password => 'password',
      :password_confirmation => 'password'
    )
    user.save
    omniauth_user = User.from_omniauth(auth_hash)

    expect(user).to eq(omniauth_user)
  end

  it "creates a new user if one doesn't already exist" do
    expect(User.count).to eq(0)

    User.from_omniauth(auth_hash)
    new_user = User.first

    expect(User.count).to eq(1)
    expect(new_user.provider).to eq("twitter")
    expect(new_user.uid).to eq("1234")
    expect(new_user.email).to eq('user@example.com')
    expect(new_user.token).to eq("mock_token")
  end
end