require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject { User.new(name: 'Something') }

    it 'should require name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'Methods' do
    before(:all) do
      User.destroy_all
      @user = FactoryBot.create :user
      create_list :recipe, 20, :name, :preparation_time, :cooking_time, :description, public: true, user: @user
      create_list :recipe, 10, :name, :preparation_time, :cooking_time, :description, public: false, user: @user
      create :recipe, :preparation_time, :cooking_time, :description, public: false, user: @user, name: 'last_added'
    end

    it 'should return all recipes ordered by creation' do
      recipes = @user.fetch_recipes

      last_added_name = recipes.first.name

      expect(recipes.length).to eq(31)
      expect(last_added_name).to eq('last_added')
    end

    it 'should return all public recipes ordered by creation' do 
      public_recipes = @user.public_recipes

      public_recipes.each do |public_recipe| 
        expect(public_recipe.public).to be true
      end
      expect(public_recipes.length).to eq(20)
    end
  end
end
