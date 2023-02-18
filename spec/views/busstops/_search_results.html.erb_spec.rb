RSpec.describe "search_results/index", type: :view do
  before do
    assign(:search_results, [
             { stop_name: "Stop A", arrival_time: "12:00", departure_time: "12:05" },
             { stop_name: "Stop B", arrival_time: "12:15", departure_time: "12:20" }
           ])
  end

  it "displays search results" do
    render
    expect(rendered).to have_selector("h1", text: "Search Results")
    expect(rendered).to have_selector("ul.list-group li.list-group-item", count: 2)
  end

  it "displays no results found message" do
    assign(:search_results, [])
    render
    expect(rendered).to have_selector("div.alert.alert-warning", text: "No results found.")
  end
end
