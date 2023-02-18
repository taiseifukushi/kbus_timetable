require "rails_helper"

RSpec.describe "layouts/application.html.erb", type: :view do
  it "renders the page title" do
    render
    expect(rendered).to have_title(I18n.t("views.page.title"))
  end
end
