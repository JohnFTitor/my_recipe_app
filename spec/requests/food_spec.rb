require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Foods', type: :request do
  describe 'GET /index' do
    it 'should visit the home page' do
      get '/'
      expect(response).to render_template(:show_public_recipes)
    end
  end

  describe 'DELETE /destroy' do
    it 'should visit the home page' do
      delete food_path(1)

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
