FactoryGirl.define do
  factory :contest do
    title "Test title"
    description "Test description"
    difficulty 1
    startDate DateTime.now
    endDate DateTime.now + 3.hours
    to_create {|instance| instance.save(validate: false) }
  end
end
