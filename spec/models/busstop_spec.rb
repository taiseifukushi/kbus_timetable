RSpec.describe Busstop, type: :model do
  describe "associations" do
    it { should have_many(:timetable) }
  end

  describe "class methods" do
    describe ".busstops_cache" do
      it "returns an array of busstops" do
        busstop = create(:busstop, stop_id: "001", stop_name: "First Busstop")
        expect(Busstop.busstops_cache).to eq([{ stop_id: "001", stop_name: "First Busstop" }])
      end

      it "caches the result of busstops method" do
        expect(Busstop).to receive(:busstops).once.and_return([])
        2.times { Busstop.busstops_cache }
      end
    end
  end
end
