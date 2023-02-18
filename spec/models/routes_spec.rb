RSpec.describe Route, type: :model do
  describe "associations" do
    it { should have_many(:timetable) }
  end

  describe "class methods" do
    describe ".busstops_cache" do
      it "returns an array of routes" do
        busstop = create(:busstop, stop_id: "001", stop_name: "First Route")
        expect(Route.busstops_cache).to eq([{ stop_id: "001", stop_name: "First Route" }])
      end

      it "caches the result of routes method" do
        expect(Route).to receive(:routes).once.and_return([])
        2.times { Route.busstops_cache }
      end
    end
  end
end
