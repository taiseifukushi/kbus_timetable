RSpec.describe TabataRoute, type: :model do
  describe "attributes" do
    it "has a stop_id attribute" do
      tabata = TabataRoute.new(stop_id: "456")
      expect(tabata.stop_id).to eq("456")
    end

    it "has a stop_name attribute" do
      tabata = TabataRoute.new(stop_name: "TabataRoute Station")
      expect(tabata.stop_name).to eq("TabataRoute Station")
    end
  end

  describe "table_name" do
    it "is 'tabatas'" do
      expect(TabataRoute.table_name).to eq("tabatas")
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
      tabata = TabataRoute.new(stop_name: "TabataRoute Station")
      expect(tabata).not_to be_valid
      expect(tabata.errors.full_messages).to include("Stop can't be blank")
    end
  end

  describe "database" do
    it "saves to the tabatas table" do
      tabata = TabataRoute.new(stop_id: "456", stop_name: "TabataRoute Station")
      expect { tabata.save }.to change { TabataRoute.count }.by(1)
    end
  end
end
