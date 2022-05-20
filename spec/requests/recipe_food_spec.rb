require 'rails_helper'

RSpec.describe "RecipeFoods", type: :request do
  describe "GET /destroy" do
    it "returns http success" do
      get "/recipe_food/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
