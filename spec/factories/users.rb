require 'faker'

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { Faker::Internet.unique.email }
    password { 123_456 }
    confirmed_at { DateTime.now }
  end
end
