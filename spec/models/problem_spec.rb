require 'rails_helper'

RSpec.describe Problem, type: :model do
  it { should validate_presence_of :name }
  it { should validate_presence_of :baseName }
  it { should validate_presence_of :timeLimit }
  it { should validate_presence_of :descriptionFile }
  it { should validate_presence_of :inputFile }
  it { should validate_presence_of :outputFile }
  it { should validate_presence_of :color }

  describe "Validate time limit is a positive number" do
    it { should validate_numericality_of(:timeLimit) }
    it { should_not allow_value(-1).for(:timeLimit) }
    it { should_not allow_value(0).for(:timeLimit) }
  end

  describe "Valid delimiter" do
    it { should allow_value("").for(:delimiter) }
    it { should_not allow_value("'").for(:delimiter) }
    it { should_not allow_value('"').for(:delimiter) }
  end

  describe "Has a valid color" do
    it { should_not allow_value("12").for(:color) }
    it { should_not allow_value("1234").for(:color) }
    it { should_not allow_value("1234567").for(:color) }

    it { should allow_value("123").for(:color) }
    it { should allow_value("123456").for(:color) }
  end
end
