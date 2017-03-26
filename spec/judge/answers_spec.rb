require 'rails_helper'

RSpec.describe Solution, type: :model do
  ["cpp", "java", "ruby", "python", "python3"].each do |lang|
    describe "Programming languages" do
      context "Ruby" do
        it "Creates a execution result" do
          Sidekiq::Testing.inline!
          expect{
            FactoryGirl.create(:solution)
          }.to change(Execution,:count).by(1)
        end

        it "Creates a execution result: #{lang} OK" do
          Sidekiq::Testing.inline!
          @rubyok = FactoryGirl.create("#{lang}_ok".to_sym)
          expect(Execution.last.status.to_i).to eq(4)
        end
        it "Creates a execution result: #{lang} WA" do
          Sidekiq::Testing.inline!
          @rubyok = FactoryGirl.create("#{lang}_wa".to_sym)
          expect(Execution.last.status.to_i>5).to be_truthy
        end
        unless ["ruby", "python", "python3"].include?(lang) then
          it "Creates a execution result: #{lang}  CE" do
            Sidekiq::Testing.inline!
            @rubyok = FactoryGirl.create("#{lang}_ce".to_sym)
            expect(Execution.last.status.to_i).to eq(1)
          end
        end
        it "Creates a execution result: #{lang} RTE" do
          Sidekiq::Testing.inline!
          @rubyok = FactoryGirl.create("#{lang}_rte".to_sym)
          expect(Execution.last.status.to_i).to eq(2)
        end
        it "Creates a execution result: #{lang} TLE" do
          Sidekiq::Testing.inline!
          @rubyok = FactoryGirl.create("#{lang}_ok".to_sym)
          expect(Execution.last.status.to_i).to eq(4)
        end
      end
    end
  end
end
