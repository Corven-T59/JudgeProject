require 'rails_helper'

RSpec.describe Solution, type: :model do
  ["cpp"].each do |lang|
    #  ["ruby", "csharp", "java", "python", "python3"].each do |lang|
    describe "12532 - Interval Product (UVA) " do
      it "Interval Product on #{lang} OK" do
        Sidekiq::Testing.inline!
        problem = FactoryGirl.create(:problem_interval)
        @ok = FactoryGirl.create("#{lang}_interval".to_sym, problem: problem)
        expect(Solution.last.status.to_i).to eq(4)
      end
    end
  end
end