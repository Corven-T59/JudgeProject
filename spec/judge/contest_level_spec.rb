require 'rails_helper'

RSpec.describe Solution, type: :model do
  ["cpp"].each do |lang|
    #  ["ruby", "csharp", "java", "python", "python3"].each do |lang|
    describe "Easy level contest" do
      it "Interval Product on #{lang} OK without segmentation" do
        Sidekiq::Testing.inline!
        contest = FactoryGirl.create(:contest, difficulty: 0)
        problem = FactoryGirl.create(:problem_interval, delimiter: "#:)#")
        @ok = FactoryGirl.create("#{lang}_interval".to_sym, problem: problem, contest: contest)
        expect(Solution.last.status.to_i).to eq(4)
      end

      it "Interval Product on #{lang} OK with segmentation" do
        Sidekiq::Testing.inline!
        contest = FactoryGirl.create(:contest, difficulty: 0)
        problem = FactoryGirl.create(:problem_interval_custom, delimiter: "#:)#")
        @ok = FactoryGirl.create("#{lang}_interval".to_sym, problem: problem, contest: contest)
        expect(Solution.last.status.to_i).to eq(4)
      end

      it "Interval Product on #{lang} WA with segmentation" do
        Sidekiq::Testing.inline!
        contest = FactoryGirl.create(:contest, difficulty: 0)
        problem = FactoryGirl.create(:problem_interval_custom, delimiter: "#:)#")
        @ok = FactoryGirl.create("#{lang}_interval_wa".to_sym, problem: problem, contest: contest)
        expect(Solution.last.status.to_i>5).to be_truthy
        expect(Solution.last.input.empty?).to be_falsy
        expect(Solution.last.output.empty?).to be_falsy
        expect(Solution.last.user_output.empty?).to be_falsy
      end
    end
  end
end