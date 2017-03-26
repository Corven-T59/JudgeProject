require 'rails_helper'

RSpec.describe "solutions/show", type: :view do
  before(:each) do
    @solution = assign(:solution, Solution.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
