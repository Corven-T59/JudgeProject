require 'rails_helper'

RSpec.describe Contest, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :difficulty }
  it { should validate_presence_of :startDate }
  it { should validate_presence_of :endDate }

  describe "Validates dates on contest" do
    it "Valid update or create" do
      contest = FactoryGirl.build(:contest, endDate: (DateTime.now + 65.minutes))
      expect(contest.valid?).to be_truthy
    end

    it "Invalid update or create" do
      contest = FactoryGirl.build(:contest, endDate: (DateTime.now + 59.minutes))
      expect(contest.valid?).to be_falsy
    end
  end
end
