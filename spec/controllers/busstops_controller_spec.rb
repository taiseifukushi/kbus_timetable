RSpec.describe BusstopsController, type: :controller do
  describe "GET #index" do
    it "assigns @busstops" do
      get :index
      expect(assigns(:busstops)).to eq(Busstop.busstops_cache)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #search" do
    let(:timetable_service) { instance_double("Util::TimetableService") }

    context "when stop name is selected" do
      before do
        allow(Util::TimetableService).to receive(:new).and_return(timetable_service)
        allow(timetable_service).to receive(:call).and_return([{}])
      end

      it "calls the Util::TimetableService" do
        post :search, params: { get_on: "123" }
        expect(Util::TimetableService).to have_received(:new).with(stop_id: "123")
        expect(timetable_service).to have_received(:call)
      end

      it "assigns @search_results" do
        post :search, params: { get_on: "123" }
        expect(assigns(:search_results)).to eq([{}])
      end

      it "sets a success flash message" do
        post :search, params: { get_on: "123" }
        expect(flash[:notice]).to eq(I18n.t("views.flash.notice"))
      end

      it "renders the search_results and flash templates" do
        post :search, params: { get_on: "123" }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('id="search_results"')
        expect(response.body).to include('data-turbo-temporary')
        expect(response.body).to include('id="flash"')
        expect(response.body).to include('data-turbo-temporary')
      end
    end

    context "when stop name is not selected" do
      it "sets an error flash message" do
        post :search, params: { get_on: nil }
        expect(flash[:alert]).to eq(I18n.t("views.flash.alert"))
      end

      it "renders the flash template" do
        post :search, params: { get_on: nil }
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('id="flash"')
        expect(response.body).to include('data-turbo-temporary')
      end
    end
  end
end
