RSpec.describe OjiRoute, type: :model do
  describe "attributes" do
    it "has a stop_id attribute" do
      oji = OjiRoute.new(stop_id: "123")
      expect(oji.stop_id).to eq("123")
    end

    it "has a stop_name attribute" do
      oji = OjiRoute.new(stop_name: "OjiRoute Station")
      expect(oji.stop_name).to eq("OjiRoute Station")
    end
  end

  describe "table_name" do
    it "is 'ojis'" do
      expect(OjiRoute.table_name).to eq("ojis")
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
      oji = OjiRoute.new(stop_name: "OjiRoute Station")
      expect(oji).not_to be_valid
      expect(oji.errors.full_messages).to include("Stop can't be blank")
    end
  end

  describe "database" do
    it "saves to the ojis table" do
      oji = OjiRoute.new(stop_id: "123", stop_name: "OjiRoute Station")
      expect { oji.save }.to change { OjiRoute.count }.by(1)
    end
  end
end
