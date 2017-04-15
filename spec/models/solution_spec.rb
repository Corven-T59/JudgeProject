require 'rails_helper'

RSpec.describe Solution, type: :model do
  it { should validate_presence_of :user }
  it { should validate_presence_of :problem }
  it { should validate_presence_of :contest }
  it { should validate_presence_of :solutionFile }
  it { should validate_presence_of :language }
  it { should belong_to :user }
  it { should belong_to :problem }
  it { should belong_to :contest }
end
