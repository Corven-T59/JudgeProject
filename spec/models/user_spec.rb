require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }

  describe "Validate user handle is valid" do
    it {should allow_value("HatsuMora").for(:handle)}
    it {should_not allow_value("sharon oie zy").for(:handle)}
  end

  describe  "validate user email" do
    it {should_not allow_value("arachni_user#^($!@$)(()))******").for(:email)}
    it { should allow_value("a@a.a").for(:email)}
  end
end
