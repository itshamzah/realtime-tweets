require 'rails_helper'
describe User, type: :model do
  it "should be invalid without phone number" do
    user = build(:user)
    user.phone = nil
    expect(user).not_to be_valid
  end
end