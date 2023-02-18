RSpec.describe Timetable, type: :model do
  describe "associations" do
    it { should belong_to(:busstop) }
  end
end
