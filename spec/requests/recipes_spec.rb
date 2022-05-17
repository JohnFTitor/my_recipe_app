require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  
  describe "GET /index" do
    it 'should redirect to login page if not authenticated' do
      get recipes_path

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
