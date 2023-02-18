require "rails_helper"

RSpec.describe "searches/new.html.erb", type: :view do
  before do
    assign(:busstops, [{ stop_name: "Stop A", stop_id: 1 }, { stop_name: "Stop B", stop_id: 2 }])
  end

  it "displays the form" do
    render
    expect(rendered).to have_selector("h1", text: "Search Form")
    expect(rendered).to have_selector("form[action='/search'][method='get']")

    expect(rendered).to have_select("search[get_on]", options: ["Stop A", "Stop B"])
    expect(rendered).to have_selector("input[type='submit'][value='Search']")
  end
end
