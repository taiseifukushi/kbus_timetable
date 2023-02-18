require "rails_helper"

RSpec.describe "searches/new.html.erb", type: :view do
  it "displays the form template" do
    render
    expect(rendered).to render_template(partial: "_form")
  end
end
