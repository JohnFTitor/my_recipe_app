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
      @user = create :user, :name, :password, :confirmed_at, email: 'user@example.com'
      create_list :recipe, 20, :name, :preparation_time, :cooking_time, :description, :public, user: @user
      create :recipe, :preparation_time, :cooking_time, :description, :public, user: @user, name: 'last_added'
    end

    it 'should return all recipes ordered by creation' do 
      recipes = @user.get_recipes

      last_added_name =recipes.first.name

      expect(recipes.length).to eq(21)
      expect(last_added_name).to eq('last_added')
    end
  end
end
