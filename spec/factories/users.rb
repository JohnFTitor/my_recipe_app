require 'faker'

FactoryBot.define do 
  factory :user do 
    trait :name do 
      name { 'John Doe' }
    end

    trait :email do 
      email { Faker::Internet.unique.email }
    end

    trait :password do 
      password { 123456 }
    end

    trait :confirmed_at do 
      confirmed_at { DateTime.now }
    end
  end
end
