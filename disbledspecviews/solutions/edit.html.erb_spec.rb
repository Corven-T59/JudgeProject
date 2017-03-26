require 'rails_helper'

RSpec.describe "solutions/edit", type: :view do
  before(:each) do
    @solution = assign(:solution, Solution.create!())
  end

  it "renders the edit solution form" do
    render

    assert_select "form[action=?][method=?]", solution_path(@solution), "post" do
    end
  end
end
