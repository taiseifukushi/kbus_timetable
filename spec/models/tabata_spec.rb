RSpec.describe Tabata, type: :model do
  describe "attributes" do
    it "has a stop_id attribute" do
      tabata = Tabata.new(stop_id: "456")
      expect(tabata.stop_id).to eq("456")
    end

    it "has a stop_name attribute" do
      tabata = Tabata.new(stop_name: "Tabata Station")
      expect(tabata.stop_name).to eq("Tabata Station")
    end
  end

  describe "table_name" do
    it "is 'tabatas'" do
      expect(Tabata.table_name).to eq("tabatas")
    end
  end

  describe "associations" do
    it "has many timetables" do
      association = described_class.reflect_on_association(:timetables)
      expect(association.macro).to eq(:has_many)
      expect(association.options).to eq({ dependent: :destroy })
    end
  end

  describe "validations" do
    it "validates presence of stop_id" do
      tabata = Tabata.new(stop_name: "Tabata Station")
      expect(tabata).not_to be_valid
      expect(tabata.errors.full_messages).to include("Stop can't be blank")
    end
  end

  describe "database" do
    it "saves to the tabatas table" do
      tabata = Tabata.new(stop_id: "456", stop_name: "Tabata Station")
      expect { tabata.save }.to change { Tabata.count }.by(1)
    end
  end
end
