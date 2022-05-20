require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Get /general_shopping_list' do
    it 'should redirect to login page if not authenticated' do
      get shopping_list_path

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
