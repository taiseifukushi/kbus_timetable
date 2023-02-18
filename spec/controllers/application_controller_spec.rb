RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      render plain: "Hello, world!"
    end
  end

  describe "GET #index" do
    it "returns HTTP success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns the correct response body" do
      get :index
      expect(response.body).to eq("Hello, world!")
    end
  end

  describe "helpers" do
    it "has a current_user helper method" do
      expect(helper).to respond_to(:current_user)
    end
  end

  describe "filters" do
    it "requires authentication for some actions" do
      controller.class.skip_before_action :authenticate_user!
      get :index
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
