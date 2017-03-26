require 'rails_helper'

RSpec.describe Execution, type: :model do
  it { should validate_presence_of :solution }
  it { should validate_presence_of :runTime }
  it { should validate_presence_of :status }
  it { should belong_to :solution}
end
