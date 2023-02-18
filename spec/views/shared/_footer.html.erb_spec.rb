require "rails_helper"

RSpec.describe "layouts/_footer.html.erb", type: :view do
  it "displays the Github Repository link" do
    render
    expect(rendered).to have_link("Github Repository", href: "https://github.com/husita-h/k_bus_norikae_app")
  end
end
