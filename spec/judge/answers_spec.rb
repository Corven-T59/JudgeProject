require 'rails_helper'

RSpec.describe Solution, type: :model do
  ["cpp", "java", "ruby", "python", "python3"].each do |lang|
    #  ["ruby", "csharp"].each do |lang|
      describe "Programming languages" do
      context lang.capitalize do
        it "Creates a execution result" do
          Sidekiq::Testing.inline!
          expect{
            FactoryGirl.create(:solution)
          }.to change(Solution, :count).by(1)
        end

        it "Creates a execution result: #{lang} OK" do
          Sidekiq::Testing.inline!
          @ok = FactoryGirl.create("#{lang}_ok".to_sym)
          expect(Solution.last.status.to_i).to eq(4)
        end
        it "Creates a execution result: #{lang} WA" do
          Sidekiq::Testing.inline!
          @wa = FactoryGirl.create("#{lang}_wa".to_sym)
          expect(Solution.last.status.to_i>5).to be_truthy
        end
        unless ["ruby", "python", "python3"].include?(lang) then
          it "Creates a execution result: #{lang} CE" do
            Sidekiq::Testing.inline!
            @ce = FactoryGirl.create("#{lang}_ce".to_sym)
            expect(Solution.last.status.to_i).to eq(1)
          end
        end
        it "Creates a execution result: #{lang} RTE" do
          Sidekiq::Testing.inline!
          @rte = FactoryGirl.create("#{lang}_rte".to_sym)
          expect(Solution.last.status.to_i).to eq(2)
        end
        it "Creates a execution result: #{lang} TLE" do
          Sidekiq::Testing.inline!
          @tle = FactoryGirl.create("#{lang}_tle".to_sym)
          expect(Solution.last.status.to_i).to eq(3)
        end
      end
    end
  end

end