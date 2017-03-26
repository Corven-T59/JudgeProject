require 'rails_helper'

RSpec.describe "solutions/new", type: :view do
  before(:each) do
    assign(:solution, Solution.new())
  end

  it "renders new solution form" do
    render

    assert_select "form[action=?][method=?]", solutions_path, "post" do
    end
  end
end
