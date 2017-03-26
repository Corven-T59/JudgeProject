FactoryGirl.define do
  factory :user do
    email "a@a.com"
    password "aaaaaa"
    password_confirmation "aaaaaa"
    admin false
  end
end
