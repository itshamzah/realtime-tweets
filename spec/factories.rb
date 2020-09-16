# frozen_string_literal: true
require 'faker'

FactoryBot.define do
  factory :user do
    provider 'twitter'
    uid "123456789"
    password '123456'
    email { Faker::Internet.email }
  end
end
