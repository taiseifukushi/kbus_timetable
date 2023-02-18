RSpec.describe Util::TimetableService do
  describe "#call" do
    let(:service) { Util::TimetableService.new(stop_id: "123") }
    let(:busstop) { create(:busstop, stop_id: "123", stop_name: "Test Busstop") }
    let(:timetable) do
      create(:timetable, stop_id: "123", trip_id: "111", arrival_time: "10:00:00", departure_time: "10:00:00")
      create(:timetable, stop_id: "123", trip_id: "222", arrival_time: "12:00:00", departure_time: "12:00:00")
    end

    before do
      busstop
      timetable
      allow(service).to receive(:just_after_records).and_return(timetable)
      allow(service).to receive(:current_time).and_return(Time.zone.parse("11:00:00"))
    end

    it "returns an array of hash objects" do
      result = service.call
      expect(result).to be_a(Array)
      expect(result[0]).to be_a(Hash)
    end

    it "returns the expected arrival time" do
      result = service.call
      expect(result[0][:arrival_time]).to eq("12:00:00")
    end

    it "returns the expected stop name" do
      result = service.call
      expect(result[0][:stop_name]).to eq("Test Busstop")
    end
  end

  describe "#just_after_records" do
    let(:service) { Util::TimetableService.new(stop_id: "123") }
    let(:timetable_1) { create(:timetable, stop_id: "123", trip_id: "111", arrival_time: "10:00:00", departure_time: "10:00:00") }
    let(:timetable_2) { create(:timetable, stop_id: "123", trip_id: "222", arrival_time: "12:00:00", departure_time: "12:00:00") }

    before do
      timetable_1
      timetable_2
      allow(service).to receive(:search_close_to_record).and_return({ trip_id: "222" })
    end

    it "returns an array of Timetable objects" do
      result = service.send(:just_after_records)
      expect(result).to be_a(ActiveTsv::Relation)
      expect(result[0]).to be_a(Timetable)
    end

    it "returns the expected records" do
      result = service.send(:just_after_records)
      expect(result.length).to eq(1)
      expect(result[0].trip_id).to eq("222")
    end
  end

  describe "#search_close_to_record" do
    let(:service) { Util::TimetableService.new(stop_id: "123") }
    let(:timetable_1) { create(:timetable, stop_id: "123", trip_id: "111", arrival_time: "10:00:00", departure_time: "10:00:00") }
    let(:timetable_2) { create(:timetable, stop_id: "123", trip_id: "222", arrival_time: "12:00:00", departure_time: "12:00:00") }

    before do
      timetable_1
      timetable_2
      allow(service).to receive(:processing_arrival_time).and_return(Time.zone.parse("12:30:00"))
      allow(service).to receive(:current_time).and_return(Time.zone.parse("12:29:00"))
    end

    it "returns the expected Timetable object" do
      result = service.send(:search_close_to_record, "123")
      expect(result).to be_a(Timetable)
      expect(result.trip_id).to eq("222")
    end
  end

  describe "private methods" do
    let(:service) { Util::TimetableService.new(stop_id: "123") }
    
    describe "#processing_activetsv_relation" do
      let(:timetable_1) { create(:timetable, stop_id: "123", trip_id: "111", arrival_time: "10:00:00", departure_time: "10:00:00") }
      let(:timetable_2) { create(:timetable, stop_id: "123", trip_id: "222", arrival_time: "12:00:00", departure_time: "12:00:00") }

      before do
        create(:busstop, stop_id: "123", stop_name: "Test Busstop")
        timetable_1
        timetable_2
      end

      it "returns an array of hash objects" do
        result = service.send(:processing_activetsv_relation, Timetable.all)
        expect(result).to be_a(Array)
        expect(result[0]).to be_a(Hash)
      end

      it "returns the expected attributes for each hash object" do
        result = service.send(:processing_activetsv_relation, Timetable.all)
        expect(result.length).to eq(2)
        expect(result[0][:arrival_time]).to eq("10:00:00")
        expect(result[0][:departure_time]).to eq("10:00:00")
        expect(result[0][:stop_id]).to eq("123")
        expect(result[0][:stop_name]).to eq("Test Busstop")
      end
    end
  end
end
