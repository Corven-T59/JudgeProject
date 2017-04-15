FactoryGirl.define do
  factory :contest do
    title "Test title"
    description "Test description"
    difficulty 1
    startDate DateTime.now + 1.hour
    endDate DateTime.now + 3.hours
  end
end
