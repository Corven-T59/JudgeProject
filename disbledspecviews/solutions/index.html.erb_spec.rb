require 'rails_helper'

RSpec.describe "solutions/index", type: :view do
  before(:each) do
    assign(:solutions, [
      Solution.create!(),
      Solution.create!()
    ])
  end

  it "renders a list of solutions" do
    render
  end
end
