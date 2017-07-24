require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }

  describe "Validate user handle is valid" do
    it {should allow_value("HatsuMora").for(:handle)}
    it {should_not allow_value("sharon oie zy").for(:handle)}
  end
end
