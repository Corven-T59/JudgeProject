FactoryGirl.define do
  factory :contest do
    title "Test title"
    description "Test description"
    difficulty 1
    startDate DateTime.now
    endDate DateTime.now + 1.day
  end
end
