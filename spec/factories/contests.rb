FactoryGirl.define do
  factory :contest do
    title "Test title"
    description "Test description"
    difficulty 1
    startDate DateTime.now + 1.minute
    endDate DateTime.now + 65.minute
  end
end
