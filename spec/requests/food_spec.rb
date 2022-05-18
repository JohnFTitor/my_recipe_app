require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "Foods", type: :request do
  describe "GET /index" do
    it 'should visit the home page' do
      get '/'
      expect(response).to render_template(:index)
    end
  end

  describe "GET /destroy" do
    it 'should visit the home page' do
      get '/'
      expect(response).to render_template(:index)
    end
  end
end
