require 'rails_helper'

RSpec.describe "BaseApis", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/base_apis/index"
      expect(response).to have_http_status(:success)
    end
  end

end
