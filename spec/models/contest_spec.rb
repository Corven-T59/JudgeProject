require 'rails_helper'

RSpec.describe Contest, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should validate_presence_of :difficulty }
  it { should validate_presence_of :startDate }
  it { should validate_presence_of :endDate }

  pending "Start datetime has to be at least one hour difference and before end datetime"
end
