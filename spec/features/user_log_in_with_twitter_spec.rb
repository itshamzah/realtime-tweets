require 'rails_helper'

RSpec.feature "user log in" do
  scenario "using twitter" do
    stub_omniauth
    visit root_path
    expect(page).to have_link("Twitter Login")
    click_link "Twitter Login"
    expect(page).to have_content("alexa")
    expect(page).to have_link("Log out")
  end

  scenario "using twitter invalid credentials" do
    stub_omniauth_invalid_credentials
    visit root_path
    expect(page).to have_link("Twitter Login")
    click_link "Twitter Login"
    expect(page).to have_content("You are not logged in yet")
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end

def stub_omniauth
  # first, set OmniAuth to run in test mode
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:twitter] = :invalid_credentials

  # then, provide a set of fake oauth data that
  # omniauth will use when a user tries to authenticate:
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
                                                                  provider: "twitter",
                                                                  uid: "12345678910",
                                                                  info: {
                                                                    email: "alexa@example.com",
                                                                    nick_name: "alexa",
                                                                  },
                                                                  extra: {
                                                                    raw_info: {
                                                                      screen_name: 'mock_screen_name',
                                                                      followers_count: 'mock_followers_count',
                                                                      friends_count: 'mock_friends_count',
                                                                      statuses_count: 'mock_statuses_count',
                                                                    }
                                                                  },
                                                                  credentials: {
                                                                    token: "abcdefg12345",
                                                                    refresh_token: "12345abcdefg",
                                                                  }
                                                              })
end

def stub_omniauth_invalid_credentials
  # first, set OmniAuth to run in test mode
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
end