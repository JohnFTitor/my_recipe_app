require 'faker'

FactoryBot.define do 
  factory :recipe do 
    trait :name do 
      name { Faker::Food.unique.dish }
    end

    trait :preparation_time do 
      preparation_time { 60.minutes }
    end

    trait :cooking_time do 
      cooking_time { 60.minutes }
    end

    trait :description do 
      description { Faker::Food.description }
    end

    trait :public do
      public { Faker::Boolean.boolean }
    end
  end
end
