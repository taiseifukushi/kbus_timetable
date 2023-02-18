RSpec.describe Util::TimeProcessor do
  describe ".processing_arrival_time" do
    it "returns a Time object" do
      arrival_time = "2022-02-18 10:00:00"
      result = Util::TimeProcessor.processing_arrival_time(arrival_time)
      expect(result).to be_a(Time)
    end

    it "returns the correct time based on the input string" do
      arrival_time = "2022-02-18 10:00:00"
      result = Util::TimeProcessor.processing_arrival_time(arrival_time)
      expect(result).to eq(Time.zone.parse(arrival_time))
    end
  end

  describe ".current_time" do
    it "returns a Time object" do
      result = Util::TimeProcessor.current_time
      expect(result).to be_a(Time)
    end

    it "returns the current time in the server's timezone" do
      expected_time = Time.now.in_time_zone(Time.zone)
      result = Util::TimeProcessor.current_time
      expect(result).to be_within(1.second).of(expected_time)
    end
  end
end
