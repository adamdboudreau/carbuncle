FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "john.doe#{n}@test.com" }
    password 'asdf1234'
    password_confirmation 'asdf1234'
  end
end