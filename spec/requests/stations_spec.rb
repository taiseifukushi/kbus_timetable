require 'rails_helper'

RSpec.describe "Stations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/stations/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/stations/create"
      expect(response).to have_http_status(:success)
    end
  end

end
