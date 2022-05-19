
require 'rails_helper'

RSpec.describe "Foods", type: :feature do

  describe "foods_path"

  it 'should get redirected to log in' do
    visit foods_path
    expect(page).to have_content('Log in')
  end

  context 'when the user is signed in' do
    before :all do
      @user = FactoryBot.create(:user)
    end

    before :each do
      visit new_user_session_path
      fill_in('Email', with: @user.email)
      fill_in('Password', with: @user.password)
      click_button 'Log in'
      visit foods_path
    end

    it 'should load foods_path' do 
      expect(page).to have_content 'Create food'
    end
  end
end
