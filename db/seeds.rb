require 'faker'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

(1..20).each do 
  User.create(
    email: Faker::Internet.unique.email,
    password: "123456",
    confirmed_at: DateTime.now,
    name: Faker::Name.name)
end

(1..100).each do
  Recipe.create(
    name: Faker::Food.dish,
    preparation_time: rand(20..40).minutes,
    cooking_time: rand(10..30).minutes,
    description: Faker::Food.description,
    public: Faker::Boolean.boolean,
    user: User.find(rand(1..20))
  )
end

(1..200).each do
  Food.create(
    name: Faker::Food.ingredient,
    measurement_unit: Faker::Food.metric_measurement,
    price: rand(5..1000),
    user: User.find(rand(1..20))
  )
end

(1..400).each do
  RecipeFood.create(
    quantity: rand(1..10),
    recipe: Recipe.find(rand(1..100)),
    food: Food.find(rand(1..200)),
  )
end
