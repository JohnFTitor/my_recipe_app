require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { create :user, :name, :password, :confirmed_at, :email }
  subject { create :recipe, :name, :preparation_time, :cooking_time, :public, user: }

  it 'should have a name attribute' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have a preparation time' do
    subject.preparation_time = nil
    expect(subject).to_not be_valid
  end

  it 'should have a cooking time' do
    subject.cooking_time = nil
    expect(subject).to_not be_valid
  end

  it 'should have an user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'should be valid without description' do
    subject.description = ''
    expect(subject).to be_valid
  end
end
