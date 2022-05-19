require 'faker'

FactoryBot.define do
  factory :food do
    name { Faker::Food.unique.ingredient }
    measurement_unit  { Faker::Food.measurement }
    price  { Faker::Number.decimal(l_digits: 2, r_digits: 2)  }
    user {FactoryBot.create :user}
  end
end
